parameter (m=10000,n=m+1)
complex cj,r,r1,r01,r02,r001,r002,realr1,realr2
parameter(cj=(0.,1.))
real min,max,uper,ran  !��ȻƵ��w
real::nn,dist ,dis,pppp,pppp1,pppp2
real::k0,k,a
real::dY(n),w(n),phase(n),phase0(n),t,sumw(n),sumww(n),ddy(n),u(n-1)
real::pi,tend
integer::mm0,mm,mmm,jj,pp,ppp,ppp1,ppp2,mmmm
pi=4*atan(1.0)
call random_seed()  
open(1000,file='n_time_phase.dat',status='unknown')
open(1,file='phasetime.dat',status='unknown')
open(11,file='pp_phasetime.dat',status='unknown')
open(111,file='ppp_phasetime.dat',status='unknown')
open(2,file='order0_mod.dat',status='unknown') !��¼��ȻƵ�ʴ���0�������
open(21,file='order1_mod.dat',status='unknown')
open(3,file='order0_fujiao.dat',status='unknown')
open(31,file='order1_fujiao.dat',status='unknown')
open(222,file='realr_mod.dat',status='unknown')
open(333,file='realr_fujiao.dat',status='unknown')
open(4,file='youxiaow.dat',status='unknown')
open(5,file='phaseend.dat',status='unknown')
open(10,file='phase_begin.dat',status='unknown')
open(30,file='W_N_10000.txt') 
open(500,file='ouheqiaodu.dat')
!open(30,file='W3.txt') 
!!!!!!��ֵ!!!!!!!!
!do i=1,m
!call random_number(ran)
!phase(i)=ran
!enddo
!enddo
!do i=1,m
!call random_number(ran)
!phase(i)=ran*2*pi
!write(10,*) phase(i)
!enddo 
do i=1,m
 call random_number(ran)
 if( ran>0) then
  phase(i)=0
  else
  phase(i)=pi
 endif
  write(10,*) phase(i)
enddo
phase(n)=0
!!!!!!��ȻƵ��w!!!!!!!!!!!!!!!!!
!˫��ֲ��������
do i=1,m
read(30,*) w(i) !��ȡ����˫��ֲ���w
enddo
!!!!!!!!!!!!!���ǿ��K!!!!!!!!!!!!!!!!
k0=0.75
k=3
write(500,*) k0,k
!!!!!!!!!!!!!!!! ����h !!!!!!!!!!
h=0.01
!!!!����!!!!!
nn=0.0
nnn=0
mmmm=0
!���е�ʱ��
t=2000
tend=1800
!!!!!!������λ!!!!!!!!!!!!
do while(abs(phase(n))<=t)
 !����ʱ��ĳ���
      nnn=nnn+1
     if(mod(nnn,80)==1) write(*,*)  phase(n) ! д��
    !  write(*,*)  phase(n),phase(2)  
	  call rungekutta4(h,k0,k,w,phase,ddy,n) 
	         do i=1,m
					do while(phase(i)>2*pi)
						phase(i)=phase(i)-2*pi
					enddo
					do while(phase(i)<=0) !ʹ��λ[0,2*pi]
					 phase(i)=phase(i)+2*pi
					enddo
			  enddo 
if(tend<phase(n)) then
	!!!!!!!!!!!!!!!!!!!!!!!!!���������r!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
	   realr1=(0.,0.)
	   realr2=(0.,0.)
       r=(0.,0.)
	   r1=(0.,0.)
	   r01=(0.,0.)
	   r02=(0.,0.)
	   r001=(0.,0.)
	   r002=(0.,0.)
	   mm=0
	   mmm=0
	   mm0=0
     do j=1,m
        	realr1=realr1+exp(cj*phase(j))
            realr2=realr2+exp(2*cj*phase(j)) !������ȻƵ�ʴ���0�����������
	   if(w(j)>0) then
        mmm=mmm+1
		r=r+exp(cj*phase(j))
        r1=r1+exp(2*cj*phase(j)) !������ȻƵ�ʴ���0�����������
	   else
        mm=mm+1
		r01=r01+exp(cj*phase(j))
        r02=r02+exp(2*cj*phase(j)) !������ȻƵ��С��0�����������
	   endif
   enddo
!!!!!!!!!!!!!!!��ȻƵ�ʼ�¼�����r,r1��ģ!!!!!!!!!!!
         call pha(1,realr1/m,theta1)
	     call pha(1,realr2/m,theta)   
         write(222,*) phase(n),abs(realr1/m),abs(realr2/m)   !��ȻƵ�ʴ���0��¼�����r,r1��ģ
         write(333,*) phase(n),theta,theta1          !��¼������ĸ���    
	 !!!!!!!!!!!��ȻƵ�ʴ���0��¼�����r,r1��ģ!!!!!!!!!!!
	   call pha(1,r1/mmm,theta1)
	   call pha(1,r/mmm,theta)
	   write(2,*) phase(n),abs(r/mmm),abs(r1/mmm) !��ȻƵ�ʴ���0��¼�����r,r1��ģ
       write(3,*) phase(n),theta,theta1          !��¼������ĸ���
       !!!!!!!!!!!��ȻƵ��С��0��¼�����r,r1��ģ!!!!!!!!!!!
       call pha(1,r01/mm,theta)
       call pha(1,r02/mm,theta1)
       write(31,*) phase(n),theta,0.5*theta1,0.5*theta1-theta  !��¼������ĸ���
	   write(21,*) phase(n),abs(r01/mm),abs(r02/mm) !��¼�����r,r1��ģ	
!!!!!!!!!!!!!!!!!!!!!��¼ÿ�����ӵ���λ�ֲ���ʱ���ݻ������!!!!!!!!!
      do jj=0,19
            ppp=0
	        pppp=0.
			ppp1=0
	        pppp1=0.
			ppp2=0
			pppp2=0. 
            dis=(2*pi/20.)*jj
            dist=(2*pi/20.)*(jj+1)
	      do i=1,n-1
	         if (phase(i)>=dis.and.phase(i)<dist) then
	          ppp=ppp+1 
	         endif
	      enddo
            if (ppp.eq.0) then
	         write(1,'(F8.3,F8.2,F12.8)')  dis, phase(n),0
	         else
	         pppp=(ppp*1.)/(m*1.0)
	        write(1,'(F8.3,F8.2,F12.8)') dis,phase(n),pppp
	        endif       
        !!!�ֱ�ͳ����ȻƵ�ʴ���0��С��0�������ӷֲ���     
	      do i=1,n-1
            if(phase(i)>=dis.and.phase(i)<dist) then
			   if(w(i)>0) then
	           ppp1=ppp1+1 
			   else
               ppp2=ppp2+1 
			   endif
			endif  
          enddo
		  !! ��ȻƵ�ʴ���0�ķֲ�
          if (ppp1.eq.0) then
	        write(11,'(F8.3,F8.2,F12.8)')  dis, phase(n),0
	      else
	         pppp1=(ppp1*1.)/(mmm*1.0)
	       write(11,'(F8.3,F8.2,F12.8)')  dis,phase(n),pppp1
	     endif
		 !��ȻƵ��С��0����λ�ֲ�
         if (ppp2.eq.0) then
	        write(111,'(F8.3,F8.2,F12.8)')  dis, phase(n),0
	     else
	         pppp2=(ppp2*1.)/(mm*1.0)
	        write(111,'(F8.3,F8.2,F12.8)') dis,phase(n),pppp2
	     endif
     enddo
!!!!!!!!!!!!!!!!!!!!!!!!!!������ЧƵ��!!!!!!!!!!!!!!!!!!
	    summ=summ+1
		sumw=sumw+ddy
!!!!!!!!!!!!!!!!��¼ÿ�����ӵ���λ��ʱ���ݻ����!!!!!!!!!!!!!!!!!!!!!!!!
  endif	
    	 	  	    	    	  	  	  	  	  	  	  	     
enddo
!!!������ЧƵ��
do i=1,m
write(5,*) phase(i)  !���һʱ�̵���λ
write(4,*) w(i),sumw(i)/summ
enddo 
stop  
end


!!!!!!!!!!!!!interation��������!!!!!!!!!!!!!!!!!!!!!!!!!
subroutine interation(k0,k,w,y,dy,n)
real::k0,k
real::  y(n),dy(n)
complex:: ccc,ouhe,ouhe1
real:: cc,w(n),cc1,a,b
integer:: i,n
ccc=(0,1)
dy(n)=1.
ouhe=0.
ouhe1=0.
        do i=1,n-1
	       ouhe=ouhe+exp(ccc*y(i))
           ouhe1=ouhe1+exp(3.*ccc*y(i))
       enddo
	    do i=1,n-1
           a=(k0/((n-1)*1.))*aimag(ouhe*exp(-ccc*y(i)))
	       b=(k/((n-1)*1.))*aimag(ouhe1*exp(-3*ccc*y(i)))
	       dy(i)=w(i)+a+b
	   enddo
return 
end 

!!!!!!!!!!!!!!!!rungekutta4��ʽ!!!!!!!!!!!!!!!!!!
subroutine  rungekutta4(h,k0,k,w,Y,dyy,n)
	integer:: n !n(������)
	real:: k0,k,h
	real::w(n),Y(n),dY(n),k1(n),k2(n),k3(n),k4(n),YY(n),dyy(n)   
	  YY=Y
	 call interation(k0,k,w,YY,dY,n)
      k1=dY*h
	  YY=Y+k1/2
     call interation(k0,k,w,YY,dY,n)
      k2=dY*h
	  YY=Y+k2/2
	 call  interation(k0,k,w,YY,dY,n)
      k3=dY*h
	  YY=Y+k3
	 call interation(k0,k,w,YY,dY,n)
	  k4=dY*h
	  Y=Y+(k1+2*k2+2*k3+k4)/6.
      dyy=(k1+2.*k2+2*k3+k4)/(h*6)
	 return
end 


SUBROUTINE pha(n,y,theta)!���㸩��
	integer n
	real theta(n),PI
	complex y(n)
	PI=atan(1.)*4
	do i=1,n
	  if(real(y(i))<0) then
	      theta(i)=atan(imag(y(i))/real(y(i)))+PI
	  endif
	  if(real(y(i))>0) then
	      if(imag(y(i))>=0) then
	       theta(i)=atan(imag(y(i))/real(y(i)))
	      endif
	      if(imag(y(i))<0) then
	       theta(i)=atan(imag(y(i))/real(y(i)))+2*pi
	      endif		  
	  endif
	  if(real(y(i))==0) then
	      if(imag(y(i))>0)  theta(i)=pi/2
	      if(imag(y(i))<0)  theta(i)=3*pi/2
	  endif
	enddo
	return
	end
