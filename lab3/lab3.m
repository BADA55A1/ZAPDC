close all;
clear;



IMG = imread('dummy-reversal-featured.jpg');
%image(IMG)
imwrite(bilinear(IMG,900,900), 'u1.png')
imwrite(nearest(IMG,900,900), 'u2.png')



function out = nearest(in,Xr,Yr)
    Xo = length(in(1,:,1));
    Yo = length(in(:,1,1));
    for y = 1:Yr
        for x = 1:Xr
            out(y,x,:) = in(round(y * Yo / Yr) , round(x * Xo / Xr) , :);
        end
    end
end

function out = bilinear(in,Xr,Yr)
    Xo = length(in(1,:,1)) -1;
    Yo = length(in(:,1,1)) -1;
    for yP = 1:Yr
        for xP = 1:Xr
            %out(y,x,:) = in(round(y * Yo / Yr) , round(x * Xo / Xr) , :);
            y = yP * Yo / Yr;
            x = xP * Xo / Xr;
            y1 = round(y);
            y2 = y1 + 1;
            x1 = round(x);
            x2 = x1 + 1;
            
            X = [(x2 - x), (x - x1)];
            Y = [(y2 - y); (y - y1)];
            Q = [in(y1, x1, :), in(y2, x1, :);  in(y1, x2, :), in(y2, x2, :)];
            for d = 1:3
                T = double(Q(:,:,d)) * (Y);
                out(yP,xP,d) = uint8(X * T);
            end
        end
    end
end


function out = rot(in, theta)
    r_matrix = [cosd(theta) -sind(theta); sind(theta) cosd(theta)];
    out = in*r_matrix;
end
