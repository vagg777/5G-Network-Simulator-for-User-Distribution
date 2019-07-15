function [macro_cells_x_pos,macro_cells_y_pos,small_cells_x_pos,small_cells_y_pos,devices_x_pos,devices_y_pos] = populateGrid(devices)

    % Create a grid and inside, a 2-by-2 km area
    %area = polyshape([-600 -600 3000 3000],[3000 -600 -600 3000]);         
    hold on;
    %plot(area);
    %grid;

    % Show all macro cells as indexed large yellow triangles with a range of 375m
    macro_cells_x_pos = [1000+750 250+750 1750+750 625+750 1375+750 625+750 1375+750 1000+750 250+750 1750+750 -125+750 2125+750 -500+750 2500+750 -120+750 250+750 1000+750 1750+750 2125+750];
    macro_cells_y_pos = [1000+750 1000+750 1000+750 1650+750 1650+750 350+750 350+750 2300+750 2300+750 2300+750 1650+750 1650+750 1000+750 1000+750 350+750 -300+750 -300+750 -300+750 350+750];
    plot(macro_cells_x_pos,macro_cells_y_pos,'^k','MarkerSize',20)
    pgon1 = rotate(nsidedpoly(6,'Center',[1000+750 1000+750],'SideLength',433),30,[1000+750 1000+750]);
    pgon2 = rotate(nsidedpoly(6,'Center',[250+750 1000+750],'SideLength',433),30,[250+750 1000+750]);
    pgon3 = rotate(nsidedpoly(6,'Center',[1750+750 1000+750],'SideLength',433),30,[1750+750 1000+750]);
    pgon4 = rotate(nsidedpoly(6,'Center',[625+750 1650+750],'SideLength',433),30,[625+750 1650+750]);
    pgon5 = rotate(nsidedpoly(6,'Center',[1375+750 1650+750],'SideLength',433),30,[1375+750 1650+750]);
    pgon6 = rotate(nsidedpoly(6,'Center',[625+750 350+750],'SideLength',433),30,[625+750 350+750]);
    pgon7 = rotate(nsidedpoly(6,'Center',[1375+750 350+750],'SideLength',433),30,[1375+750 350+750]);
    pgon8 = rotate(nsidedpoly(6,'Center',[1000+750 2300+750],'SideLength',433),30,[1000+750 2300+750]);
    pgon9 = rotate(nsidedpoly(6,'Center',[250+750 2300+750],'SideLength',433),30,[250+750 2300+750]);
    pgon10 = rotate(nsidedpoly(6,'Center',[1750+750 2300+750],'SideLength',433),30,[1750+750 2300+750]);
    pgon11 = rotate(nsidedpoly(6,'Center',[-125+750 1650+750],'SideLength',433),30,[-125+750 1650+750]);
    pgon12 = rotate(nsidedpoly(6,'Center',[2125+750 1650+750],'SideLength',433),30,[2125+750 1650+750]);
    pgon13 = rotate(nsidedpoly(6,'Center',[-500+750 1000+750],'SideLength',433),30,[-500+750 1000+750]);
    pgon14 = rotate(nsidedpoly(6,'Center',[2500+750 1000+750],'SideLength',433),30,[2500+750 1000+750]);
    pgon15 = rotate(nsidedpoly(6,'Center',[-120+750 350+750],'SideLength',433),30,[-120+750 350+750]);
    pgon16 = rotate(nsidedpoly(6,'Center',[250+750 -300+750],'SideLength',433),30,[250+750 -300+750]);
    pgon17 = rotate(nsidedpoly(6,'Center',[1000+750 -300+750],'SideLength',433),30,[1000+750 -300+750]);
    pgon18 = rotate(nsidedpoly(6,'Center',[1750+750 -300+750],'SideLength',433),30,[1750+750 -300+750]);
    pgon19 = rotate(nsidedpoly(6,'Center',[2125+750 350+750],'SideLength',433),30,[2125+750 350+750]);
    
    plot(pgon1,'FaceColor','k','FaceAlpha',0.3);
    plot(pgon2,'FaceColor','k','FaceAlpha',0.3);
    plot(pgon3,'FaceColor','k','FaceAlpha',0.3);
    plot(pgon4,'FaceColor','k','FaceAlpha',0.3);
    plot(pgon5,'FaceColor','k','FaceAlpha',0.3);
    plot(pgon6,'FaceColor','k','FaceAlpha',0.3);
    plot(pgon7,'FaceColor','k','FaceAlpha',0.3);
    plot(pgon8,'FaceColor','k','FaceAlpha',0.1);
    plot(pgon9,'FaceColor','k','FaceAlpha',0.1);
    plot(pgon10,'FaceColor','k','FaceAlpha',0.1);
    plot(pgon11,'FaceColor','k','FaceAlpha',0.1);
    plot(pgon12,'FaceColor','k','FaceAlpha',0.1);
    plot(pgon13,'FaceColor','k','FaceAlpha',0.1);
    plot(pgon14,'FaceColor','k','FaceAlpha',0.1);
    plot(pgon15,'FaceColor','k','FaceAlpha',0.1);
    plot(pgon16,'FaceColor','k','FaceAlpha',0.1);
    plot(pgon17,'FaceColor','k','FaceAlpha',0.1);
    plot(pgon18,'FaceColor','k','FaceAlpha',0.1);
    plot(pgon19,'FaceColor','k','FaceAlpha',0.1);
    
    text(1000+60+750,1000+30+750,'1','fontsize',15,'Color','k');
    text(250+60+750,1000+30+750,'2','fontsize',15,'Color','k');
    text(1750+60+750,1000+30+750,'3','fontsize',15,'Color','k');
    text(625+60+750,1650+30+750,'4','fontsize',15,'Color','k');
    text(1375+60+750,1650+30+750,'5','fontsize',15,'Color','k');
    text(625+60+750,350+30+750,'6','fontsize',15,'Color','k');
    text(1375+60+750,350+30+750,'7','fontsize',15,'Color','k');
    text(1000+60+750,2300+30+750,'8','fontsize',15,'Color','k');
    text(250+60+750,2300+30+750,'9','fontsize',15,'Color','k');
    text(1750+60+750,2300+30+750,'10','fontsize',15,'Color','k');
    text(-125+60+750,1650+30+750,'11','fontsize',15,'Color','k');
    text(2120+60+750,1650+30+750,'12','fontsize',15,'Color','k');
    text(-500+60+750,1000+30+750,'13','fontsize',15,'Color','k');
    text(2500+60+750,1000+30+750,'14','fontsize',15,'Color','k');
    text(-120+60+750,350+30+750,'15','fontsize',15,'Color','k');
    text(250+60+750,-300+30+750,'16','fontsize',15,'Color','k');
    text(1000+60+750,-300+30+750,'17','fontsize',15,'Color','k');
    text(1750+60+750,-300+30+750,'18','fontsize',15,'Color','k');
    text(2125+60+750,350+30+750,'19','fontsize',15,'Color','k');

    %Show all small cells as indexed small blue triagles with a range of 50m
    small_cells_x_pos = [1250+750 750+750  1200+750 50+750  520+750 280+750  350+750  900+750  600+750  1700+750 1050+750 1350+750 2050+750 1500+750 1900+750 350+750 900+750 650+750 1050+750 1450+750 1600+750];
    small_cells_y_pos = [1150+750 1000+750 750+750  800+750 850+750 1250+750 1500+750 1650+750 1900+750 1700+750 1650+750 1350+750 1100+750 850+750  750+750  350+750 500+750 50+750  350+750  650+750  120+750];
    plot(small_cells_x_pos,small_cells_y_pos,'^b','MarkerSize',9)
    viscircles([1250+750 1150+750],55,'Color','b');
    viscircles([750+750 1000+750],55,'Color','b');
    viscircles([1200+750 750+750],55,'Color','b');
    viscircles([50+750 800+750],55,'Color','b');
    viscircles([520+750 850+750],55,'Color','b');
    viscircles([280+750 1250+750],55,'Color','b');
    viscircles([350+750 1500+750],55,'Color','b');
    viscircles([900+750 1650+750],55,'Color','b');
    viscircles([600+750 1900+750],55,'Color','b');
    viscircles([1700+750 1700+750],55,'Color','b');
    viscircles([1050+750 1650+750],55,'Color','b');
    viscircles([1350+750 1350+750],55,'Color','b');
    viscircles([2050+750 1100+750],55,'Color','b');
    viscircles([1500+750 850+750],55,'Color','b');
    viscircles([1900+750 750+750],55,'Color','b');
    viscircles([350+750 350+750],55,'Color','b');
    viscircles([900+750 500+750],55,'Color','b');
    viscircles([650+750 50+750],55,'Color','b');
    viscircles([1050+750 350+750],55,'Color','b');
    viscircles([1450+750 650+750],55,'Color','b');
    viscircles([1600+750 120+750],55,'Color','b');
    text(1250+13+750,1150+13+750,'1','fontsize',8,'Color','b');
    text(750+13+750,1000+13+750,'2','fontsize',8,'Color','b');
    text(1200+13+750,750+13+750,'3','fontsize',8,'Color','b');
    text(50+13+750,800+13+750,'4','fontsize',8,'Color','b');
    text(520+13+750,850+13+750,'5','fontsize',8,'Color','b');
    text(280+13+750,1250+13+750,'6','fontsize',8,'Color','b');
    text(350+13+750,1500+13+750,'7','fontsize',8,'Color','b');
    text(900+13+750,1650+13+750,'8','fontsize',8,'Color','b');
    text(600+13+750,1900+13+750,'9','fontsize',8,'Color','b');
    text(1700+13+750,1700+13+750,'10','fontsize',8,'Color','b');
    text(1050+13+750,1650+13+750,'11','fontsize',8,'Color','b');
    text(1350+13+750,1350+13+750,'12','fontsize',8,'Color','b');
    text(2050+13+750,1100+13+750,'13','fontsize',8,'Color','b');
    text(1500+13+750,850+13+750,'14','fontsize',8,'Color','b');
    text(1900+13+750,750+13+750,'15','fontsize',8,'Color','b');
    text(350+13+750,350+13+750,'16','fontsize',8,'Color','b');
    text(900+13+750,500+13+750,'17','fontsize',8,'Color','b');
    text(650+13+750,50+13+750,'18','fontsize',8,'Color','b');
    text(1050+13+750,350+13+750,'19','fontsize',8,'Color','b');
    text(1450+13+750,650+13+750,'20','fontsize',8,'Color','b');
    text(1600+13+750,120+13+750,'21','fontsize',8,'Color','b');
    
    
    devices_x_pos = zeros(1,devices);                          
    devices_y_pos = zeros(1,devices);
    for j = 1:devices
       possibility = rand;  
       if possibility <= 0.10                                   % Devices go by 90% inside a macrocell area and 10% in a non-covered area        
            position_probability = rand;
            if position_probability <= 0.5                      % With equal probability, add non-covered device on the far left or far right of the simulation
                devices_x_pos(j) = randi([0 250])+750;             
                devices_y_pos(j) = randi([0 2000])+750;             
            else
                devices_x_pos(j) = randi([1750 2000])+750;          
                devices_y_pos(j) = randi([0 2000])+750;             
            end
       else
            devices_x_pos(j) = randi([250 1750])+750;               
            devices_y_pos(j) = randi([0 2000])+750;                 
       end
       % Add UE to map as a red square icon
       plot(devices_x_pos(j), devices_y_pos(j), 'sr');          
       display_text = num2str(j);
       text(devices_x_pos(j)+13,devices_y_pos(j)+13,display_text,'fontsize',10,'Color','r');
    end
    
    hold off;

end