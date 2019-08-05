aa = load('CN_Biart.mat')

L1=0.315; L2=0.234;
I = []
J = []
%J2 = double(J1)
CN1 = aa.CN
CN1= double(CN1)
CN2 = []
counter = 1
for teta_a = 1:30:110
    for teta_b = 1:30:150
         
         if isreal(CN1(counter))
             i = L1*cosd(teta_a)+L2*cosd(teta_a+teta_b)
             I = [I,i]
             j = L1*sind(teta_a)+L2*cosd(teta_a+teta_b)
             J = [J,j]
             CN2 = [CN2,CN1(counter)]
         end
         counter = counter + 1
             

    end
         
         
             
         %counter = counter + 1
         
 end


scatter3(I,J,CN2)
xlabel('x')
ylabel('y')
zlabel('z')
%zlim([0 0.01])

 