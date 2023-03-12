function patt = loomingObject(tao)
%LOOMINGOBJECT looming stimuli production by an approaching object with constant velocity
%   Code written by Shengkai Xi
%   December 20, 2022

screenXpix = 800;
screenYpix = 600;
xCenter = round(screenXpix/2);
yCenter = round(screenYpix/2);

width = 100;
length = 100;
d0 = 240;                                         %eye to screen

pos_input = 0;                                   %-180~+180,clock:0:00~6:00 =0~+180...12:00~6:00 = 0~-180
radius_input = 0;                                 %0~60
radar = pos_input*pi/180;
radius = radius_input*pi/180;
x_shift = round(sin(radar)*tan(radius)*d0);
y_shift = -round(cos(radar)*tan(radius)*d0);

d21 = round((length/2)*d0/(yCenter + abs(y_shift)));
d22 =  round((width/2)*d0/(xCenter + abs(x_shift)));
d20 = min(d21,d22);

v_o = 0.5*length/tao;                              %v of object approaching
t = 1;
d1 = d20+t*v_o;                                    %real time distance
d2 = d1;
refresh_rate = 100;
frame = refresh_rate*t;

patt = ones(screenYpix,screenXpix,frame);
%--------------------------------------------------------------------------

for idx = 1:frame
    if d2>0
        d2 = d1-round(idx*v_o/refresh_rate);
        length_1 = length*d0/d2;
        width_1  =  width*d0/d2;
        
        up   = round(y_shift-length_1/2+yCenter);
        if up<1
            up = 1;
        end
        bot  = round(y_shift+length_1/2+yCenter);
        if bot>screenYpix
            bot = screenYpix;
        end
        left  = round(x_shift-width_1/2+xCenter);
        if left<1
            left = 1;
        end
        right = round(x_shift+width_1/2+xCenter);
        if right>screenXpix
            right = screenXpix;
        end
    end
    
    patt(up:bot,left:right,idx) = 0;
end

end
