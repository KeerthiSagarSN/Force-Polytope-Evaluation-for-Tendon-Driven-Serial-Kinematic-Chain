aa = load('CN_biart_heatmap')
CN = aa.CN
counter = 1
tbl = []
for i=-0.4:0.05:0.4
     for j =-0.2:0.05:0.6
         tb1 = table(i,j,CN(counter))
         if isreal(CN(counter))
         
         tb1 = table(i,j,CN(counter))
         counter = counter +1
         else
             tb1 = table(i,j,CN(counter))
         counter = counter +1
         end
     end
end
h = heatmap(tb1)