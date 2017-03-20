parameter (m=10000,n=m+1)
complex cj,r0,r
parameter(cj=(0.,1.))
real min,max,uper,ran  !��ȻƵ��w
real::r1,r2 
real::k0,k,a
real::dY(n),w(n),phase(n),phase0(n),t,sumw(n),sumww(n),ddy(n),u(n-1),noise(n-1),D
real::pi,tend
integer nn,nnn,II,summ
CHARACTER(LEN=80) ::FILENAME0, FILENAME1,FILENAME2,FORM
pi=4*atan(1.0)
open(2,file='ordermod.dat',status='unknown')
open(10,file='phase_begin.dat',status='unknown')
open(30,file='W_N_10000.txt') 
!open(10,file='phase0.txt') 
call random_seed()
!open(30,file='W3.txt') 
!!!!!!��ֵ����!!!!!!!!
do i=1,m
read(10,*) phase(i)
enddo
!enddo
!!!!!!��ȻƵ��w!!!!!!!!!!!!!!!!!
!do i=1,m
 !  if(i<m/2) then
!	 call random_number(ran)
  !   w(i)=tan(2*pi*ran)-3.
 !    do while(w(i)<-10.or.w(i)>10) 
!	   call  random_number(ran)
!       w(i)=tan(2*pi*ran)-3.
!	 end do
!  else
!	   call   random_number(ran)
 !      w(i)=tan(2*pi*ran)+3.
  !    do while(w(i)<-10.or.w(i)>10) 
!		  call  random_number(ran)
 !         w(i)=tan(2*pi*ran)+3.
!	   end do
 !  end if
!write(3,*) w(i)
!enddo
!˫��ֲ��������
do i=1,m
read(30,*) w(i) !��ȡ���ӵ���ֲ���w
enddo
!!!!!!!!!!!!!����!!!!!!!!!!!!!!!!
D=1.2
!!!!!!!!!!!!!!!! ����h !!!!!!!!!!
h=0.01
!���е�ʱ��
nn=0
II=0 !�ļ���
t=2000
tend=1800
k0=1.25
do k=3.75,0.75,-0.15
   II=II+1
  write(*,*) II,k0,k  !д��
   !!!!ÿ�δ���һ���ļ���!!!!!!!!!
   SELECT CASE (II)  
    CASE (1:9)
      WRITE(FORM,'(I1)') II   
    CASE (10:99)
      WRITE(FORM,'(I2)') II
    CASE (100:999)
      WRITE(FORM,'(I3)') II
    END SELECT
    WRITE(FILENAME1,*) "phase_end_",TRIM(FORM),".dat" !������¼���һʱ�̵���λ���ļ���
    WRITE(FILENAME2,*) "youxiaopinglv_",TRIM(FORM),".dat"   !������¼��ЧƵ�ʵ��ļ���
   !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!   
  !!!!!!!!!!!!!!!!!!!!!��ʼ����!!!!!!!!!!!!!!!!!!!!!!!!!!!!
   phase(n)=0.
   !!!!!!!!!!!!!!!!!!!!!!!!!!!!!
   nnn=0
   !!!!!!!!!!!!!��ЧƵ�ʹ���!!!!!!!!!!!
	do i=1,m
	sumw(i)=0.0
	enddo
	!!!!!!!!!!!!!!!!!!!!!!!!�����!!!!!!!!!!!!!!!!!!!!!!
    r1=0.0
    r2=0.0
	!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
   do while(abs(phase(n))<=t) !����ʱ��ĳ���
	 nn=nn+1
	 if(mod(nn,4000)==1) write(*,*) phase(n)
	   call rungekutta4(h,k0,k,w,phase,ddy,n,noise,D)
	         do i=1,m
					do while(phase(i)>2*pi)
						phase(i)=phase(i)-2*pi
					enddo
					do while(phase(i)<=0) !ʹ��λ[0,2*pi]
					 phase(i)=phase(i)+2*pi
					enddo
			  enddo 
	!!!!!!!!!!!!!��ȥ��̬!!!!!!!!!!!!!!!!!!!!!
     if(tend<phase(n)) then
	!!!!!!!!!!!!!!!!!!!!!!!!!���������r!!!!!!!!!
	   nnn=nnn+1
       r0=(0.,0.)
	   r=(0.,0.)
       do j=1,m
		r0=r0+exp(cj*phase(j))
        r=r+exp(2*cj*phase(j))
       enddo
	   r1=r1+abs(r0/m)
	   r2=r2+abs(r/m)  
     !!!!!!!!!!!!!!!!!!!!!!!!!!������ЧƵ��!!!!!!!!!!!!!!!!!!
	   sumw=sumw+ddy     		                  
     endif	 	  	 		 	  	    	    	  	  	  	  	  	  	  	     
enddo

write(2,*) k0,k,r1/nnn,r2/nnn  !��¼�����r1,r2�����ǿ��k2

open(99,file=FILENAME1) 
open(100,file=FILENAME2) 
do i=1,m
write(99,*)  phase(i) !��¼ÿ�����ǿ���µ����һʱ����λ
write(100,*) w(i),sumw(i)/nnn !��¼��ЧƵ������ȻƵ��
enddo 
close(99)
close(100)

enddo
stop  
end



subroutine interation(k0,k,w,y,dy,n,noise,D)
real::k0,k
real::  y(n),dy(n),D,noise(n-1)
complex:: ccc,ouhe,ouhe1
real:: cc,w(n),cc1,a,b
integer:: i,n
ccc=(0,1)
ouhe=0.
ouhe1=0.
        do i=1,n-1
	       ouhe=ouhe+exp(ccc*y(i))
           ouhe1=ouhe1+exp(2.*ccc*y(i))
       enddo
	    do i=1,n-1
           a=(k0/((n-1)*1.))*aimag(ouhe*exp(-ccc*y(i)))
	       b=(k/((n-1)*1.))*aimag(ouhe1*exp(-2*ccc*y(i)))
	       dy(i)=w(i)+a+b+sqrt(D)*noise(i)
	   enddo
	   dy(n)=1.
return 
end 
!!!!!!!!!!!!!!����������!!!!!!!!!!!!!!!!!!!!!!!!!!!!


subroutine niosefun(n,noise)                                         !!�ӳ������ɸ�˹������   
implicit none
integer n,i
real u1,u2,pi,noise(n)
call random_seed()
pi=3.141592654
do i=1,n                                                                  !!�����ض�ʱ�̣�ÿ�����ӵ�������ͬ
  call random_number(u1)
  call random_number(u2)
  noise(i)=sqrt(-2*log(u1))*cos(2*pi*u2)
enddo
return
end




!!!!!!!!!!!!!!!!rungekutta4��ʽ!!!!!!!!!!!!!!!!!!
subroutine  rungekutta4(h,k0,k,w,Y,dyy,n,noise,D)
	integer:: n !n(������)
	real:: k0,k,h
	real::w(n),Y(n),dY(n),k1(n),k2(n),k3(n),k4(n),YY(n),dyy(n),noise(n-1),D  
	  YY=Y
	 call  niosefun(n-1,noise) 
	 call interation(k0,k,w,y,dy,n,noise,D)
      k1=dY*h
	  YY=Y+k1/2
     call interation(k0,k,w,y,dy,n,noise,D)
      k2=dY*h
	  YY=Y+k2/2
	 call interation(k0,k,w,y,dy,n,noise,D)
      k3=dY*h
	  YY=Y+k3
	 call interation(k0,k,w,y,dy,n,noise,D)
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
