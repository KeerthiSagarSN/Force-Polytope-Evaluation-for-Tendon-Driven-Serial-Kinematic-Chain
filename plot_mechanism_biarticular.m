function pt = plot_mechanism_biarticular(L,b,d,h,u,s,ra,rb,c_ab,s_ab,teta_a,teta_b)

pt_O = [0 0]
pt1 = [-h(1) d(1)]
pt1_O = [-h(1) 0]
pt2 = [h(2) d(2)]
pt2_O = [h(2) 0]
pt3 = [-u(1) b(1)]
pt3_O = [-u(1) 0]
pt4 = [u(2) b(2)]
pt4_O = [u(2) 0]
pt5_teta = teta_a + atan((s(1)/ra))
pt5 = [sqrt(ra^2+s(1)^2)*cos(pt5_teta) sqrt(ra^2+s(1)^2)*sin(pt5_teta)]

pt6_teta = teta_a - atan((s(2)/rb))
pt6 = [sqrt(rb^2+s(2)^2)*cos(pt6_teta) sqrt(rb^2+s(2)^2)*sin(pt6_teta)]

Rot_mat = [cos(teta_a+teta_b) -sin(teta_a+teta_b); sin(teta_a+teta_b) cos(teta_a+teta_b)];
Trans_mat = [L(1)*cos(teta_a) L(1)*sin(teta_a)]



pt7 = Rot_mat*[h(3) d(3)]' + Trans_mat'
pt7_O = Rot_mat*[h(3) 0]' + Trans_mat'
pt8 = Rot_mat*[-h(4) d(4)]' + Trans_mat'
pt8_O = Rot_mat*[-h(4) 0]' + Trans_mat'
pt9 = Rot_mat*[u(3) b(3)]' + Trans_mat'
pt9_O = Rot_mat*[u(3) 0]' + Trans_mat'
pt10 = Rot_mat*[-u(4) b(4)]' + Trans_mat'
pt10_O = Rot_mat*[-u(4) 0]' + Trans_mat'

pt_e = Rot_mat*[L(2) 0]' + Trans_mat'

pt_second_O = Trans_mat'


plot([pt_O(1),pt_second_O(1)],[pt_O(2),pt_second_O(2)])
hold on
plot([pt_O(1),pt1_O(1)],[pt_O(2),pt1_O(2)])
hold on
plot([pt_O(1),pt2_O(1)],[pt_O(2),pt2_O(2)])
hold on
plot([pt_O(1),pt3_O(1)],[pt_O(2),pt3_O(2)])
hold on
plot([pt_O(1),pt4_O(1)],[pt_O(2),pt4_O(2)])
hold on

plot([pt1_O(1),pt1(1)],[pt1_O(2),pt1(2)])
hold on
plot([pt2_O(1),pt2(1)],[pt2_O(2),pt2(2)])
hold on
plot([pt3_O(1),pt3(1)],[pt3_O(2),pt3(2)])
hold on
plot([pt4_O(1),pt4(1)],[pt4_O(2),pt4(2)])
hold on


plot([pt1(1),pt5(1)],[pt1(2),pt5(2)])
hold on
plot([pt2(1),pt6(1)],[pt2(2),pt6(2)])
hold on
plot([pt5(1),pt7(1)],[pt5(2),pt7(2)])
hold on


plot([pt1(1),pt5(1)],[pt1(2),pt5(2)])
hold on
plot([pt2(1),pt6(1)],[pt2(2),pt6(2)])
hold on
plot([pt5(1),pt7(1)],[pt5(2),pt7(2)])
hold on
plot([pt6(1),pt8(1)],[pt6(2),pt8(2)])
hold on
plot([pt3(1),pt9(1)],[pt3(2),pt9(2)])
hold on
plot([pt4(1),pt10(1)],[pt4(2),pt10(2)])
hold on

pt_e
plot([pt7_O(1),pt7(1)],[pt7_O(2),pt7(2)])
hold on
plot([pt8_O(1),pt8(1)],[pt8_O(2),pt8(2)])
hold on
plot([pt9_O(1),pt9(1)],[pt9_O(2),pt9(2)])
hold on
plot([pt10_O(1),pt10(1)],[pt10_O(2),pt10(2)])
hold on
plot([pt8_O(1),pt7_O(1)],[pt8_O(2),pt7_O(2)])
hold on
plot([pt_second_O(1),pt_e(1)],[pt_second_O(2),pt_e(2)])
hold on



end