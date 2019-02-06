clear all
close all

load topsilout.xy

outx = topsilout(:,1);
outy = topsilout(:,2);

load topsilin.xy

inx = topsilin(:,1);
iny = topsilin(:,2);

figure
plot(outx,outy,inx,iny)
set(gcf,'position',[10,10,600,500])
legend('Outside Test Chamber','Inside Test Chamber')
title('Topsil reference')
xlabel('wavelength in nm')
ylabel('Reflectance')


load S-T315_asprep_out.xy

sx1 = S_T315_asprep_out(:,1);
sy1 = S_T315_asprep_out(:,2);

load ST315_asprep_in.xy

sx2 = ST315_asprep_in(:,1);
sy2 = ST315_asprep_in(:,2);

figure
plot(sx1,sy1,sx2,sy2)
set(gcf,'position',[10,10,600,500])
legend('Outside Test Chamber','Inside Test Chamber')
title('Polystyrene')
xlabel('wavelength in nm')
ylabel('Reflectance')

load I-T319_asprep_out.xy

ix1 = I_T319_asprep_out(:,1);
iy1 = I_T319_asprep_out(:,2);

load IT319_asprep_in.xy

ix2 = IT319_asprep_in(:,1);
iy2 = IT319_asprep_in(:,2);

figure
plot(ix1,iy1,ix2,iy2)
set(gcf,'position',[10,10,600,500])
legend('Outside Test Chamber','Inside Test Chamber')
title('Isoprene')
xlabel('wavelength in nm')
ylabel('Reflectance')


load M-T321_asprep_out.xy

mx1 = M_T321_asprep_out(:,1);
my1 = M_T321_asprep_out(:,2);

load MT321_asprep_in.xy

mx2 = MT321_asprep_in(:,1);
my2 = MT321_asprep_in(:,2);

figure
plot(mx1,my1,mx2,my2)
set(gcf,'position',[10,10,600,500])
legend('Outside Test Chamber','Inside Test Chamber')
title('Methyl Methacrylate')
xlabel('wavelength in nm')
ylabel('Reflectance')


