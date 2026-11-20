import pandas as pd, numpy as np, sys
from scipy import stats
import os
up=os.path.join(os.path.dirname(__file__),"..","data","raw")+os.sep
out=os.path.join(os.path.dirname(__file__),"..","data")+os.sep
oni=pd.read_csv(up+"oni.ascii.txt",sep=r"\s+")
oni.columns=["Season","Year","Total","ONI"]
centre={"DJF":1,"JFM":2,"FMA":3,"MAM":4,"AMJ":5,"MJJ":6,"JJA":7,"JAS":8,"ASO":9,"SON":10,"OND":11,"NDJ":12}
oni["Month"]=oni.Season.map(centre)
oni["Date"]=pd.to_datetime(dict(year=oni.Year,month=oni.Month,day=1))
oni["Phase"]=np.where(oni.ONI>=0.5,"El Niño",np.where(oni.ONI<=-0.5,"La Niña","Neutral"))
oni[["Date","Year","Season","ONI","Phase"]].to_csv(out+"oni_monthly.csv",index=False)

def seas(seasons, lag=0):
    d=oni[oni.Season.isin(seasons)].groupby("Year").ONI.mean()
    d.index=d.index+lag; return d
grow={"Australia":seas(["JJA","JAS","ASO","SON"]),          # Jun-Nov winter crop
      "Canada":seas(["MJJ","JJA","JAS"]),                   # May-Aug
      "India":seas(["JJA","JAS","ASO"],lag=1),             # prior monsoon -> rabi harvest
      "Türkiye":seas(["NDJ","DJF","JFM","FMA","MAM"]),     # winter-spring
      "United States of America":seas(["MJJ","JJA","JAS"])}

p=pd.read_csv(up+"faostat_lentil_production.csv")
p=p.pivot_table(index=["Area","Year"],columns="Element",values="Value").reset_index()
p.columns.name=None
p=p.rename(columns={"Area":"Country","Area harvested":"Area_ha","Yield":"Yield_kg_ha","Production":"Production_t"})
rows=[]
for c,g in p.groupby("Country"):
    g=g.sort_values("Year").copy()
    sl=stats.linregress(g.Year,g.Yield_kg_ha)
    g["Yield_trend"]=sl.intercept+sl.slope*g.Year
    g["Yield_anom_pct"]=(g.Yield_kg_ha/g.Yield_trend-1)*100
    g["ONI_growing_season"]=g.Year.map(grow[c])
    rows.append(g)
p=pd.concat(rows)
p["ENSO_phase"]=np.where(p.ONI_growing_season>=0.5,"El Niño",np.where(p.ONI_growing_season<=-0.5,"La Niña","Neutral"))
p.round(3).to_csv(out+"lentil_production_enso.csv",index=False)

t=pd.read_csv(up+"faostat_india_lentil_imports.csv")
t=t.pivot_table(index=["Partner Countries","Year"],columns="Element",values="Value").reset_index()
t.columns.name=None
t=t.rename(columns={"Partner Countries":"Partner","Import quantity":"Qty_t","Import value":"Value_kUSD"})
full=pd.MultiIndex.from_product([t.Partner.unique(),range(2000,2025)],names=["Partner","Year"])
t=t.set_index(["Partner","Year"]).reindex(full).fillna(0).reset_index()
t["Unit_value_USD_t"]=np.where(t.Qty_t>0,t.Value_kUSD*1000/t.Qty_t,np.nan)
tot=t.groupby("Year").Qty_t.transform("sum")
t["Share_pct"]=t.Qty_t/tot*100
t.round(2).to_csv(out+"india_lentil_imports_clean.csv",index=False)

# ---------- analysis ----------
print("=== Yield anomaly vs growing-season ONI ===")
for c,g in p.groupby("Country"):
    g=g.dropna(subset=["ONI_growing_season"])
    r,pv=stats.pearsonr(g.ONI_growing_season,g.Yield_anom_pct)
    ph=g.groupby("ENSO_phase").Yield_anom_pct.agg(["mean","count"]).round(1)
    print(f"\n{c}: r={r:.2f} p={pv:.3f} n={len(g)}"); print(ph.to_string())
au=p[p.Country=="Australia"].set_index("Year")
print("\nAustralia worst yield years:"); print(au.nsmallest(6,"Yield_anom_pct")[["Yield_kg_ha","Yield_anom_pct","ONI_growing_season","ENSO_phase"]].round(2).to_string())

w=t.pivot(index="Year",columns="Partner",values="Qty_t")
w["Total"]=w.sum(axis=1); w["CanShare"]=w["Canada"]/w["Total"]*100; w["AusShare"]=w["Australia"]/w["Total"]*100
w["AU_anom_prev"]=au.Yield_anom_pct.reindex(w.index-1).values
w["AU_prod_prev"]=au.Production_t.reindex(w.index-1).values
w["ONI_AU_prev"]=au.ONI_growing_season.reindex(w.index-1).values
ind=p[p.Country=="India"].set_index("Year")
w["IN_anom"]=ind.Yield_anom_pct.reindex(w.index).values
print("\n=== India imports table ==="); print(w[["Canada","Australia","Total","CanShare","AU_anom_prev","ONI_AU_prev","IN_anom"]].round(1).to_string())
for a,b in [("ONI_AU_prev","CanShare"),("AU_anom_prev","CanShare"),("ONI_AU_prev","Total"),("IN_anom","Total")]:
    d=w[[a,b]].dropna(); r,pv=stats.pearsonr(d[a],d[b]); print(f"{a} vs {b}: r={r:.2f} p={pv:.3f} n={len(d)}")
