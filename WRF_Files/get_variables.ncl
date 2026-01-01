FILES = systemfunc (" ls -1 " + "wrfout_d02_2024* ")  ; The WRF ARW input file.
a = addfiles(FILES+".nc","r")
;a = addfiles("wrfout_d02_2019-02-28_00:00:00.nc","r")
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;i = 78  ; Sable
;j = 53

;i = 136  ; St John's
;j = 99

;i = 48  ; Halifax
;j = 65

i = 25   ; Yarmouth
j = 54

;i = 66   ; Port Hawkesbury
;j = 74

file_name = "Yarmouth_2024.csv"
system("rm -f " + file_name)
write_table(file_name,"w",[/"Time","T2","TD2","T2-TD2","U","V","RH2","P_sfc","QC"/],"%s  %s %s %s %s %s %s %s %s")

times = wrf_user_getvar(a,"times",-1)
ntimes = dimsizes(times)

do it = 0,ntimes-1
   t2 = wrf_user_getvar(a,"T2",it)
   T2 = t2(j,i)
   T2 = T2- 273.15
   td2 = wrf_user_getvar(a,"td2",it)
   TD2 = td2(j,i)
   T2_TD2 = T2-TD2
   U = wrf_user_getvar(a,"U10",it)
   u = U(j,i)
   U1= wrf_user_getvar(a,"ua",it)
   u1= U1(0,53,76)
   V = wrf_user_getvar(a,"V10",it)
   v = V(j,i)
   V1= wrf_user_getvar(a,"va",it)
   v1= V1(0,51,78)
   ws = wind_speed(u,v)
   wd = wind_direction(u,v,1)
   rh = wrf_user_getvar(a,"rh2",it)
   rh = rh/100 
   RH = rh(j,i)
   t  = wrf_user_getvar(a,"tc",it)
   t1 = t(0,53,78)
   t12 = t(0,53,74)
   t3 = t(0,49,78)
   t_adv = u1*(t12-t1)/36000 + v1*(t3-t1)/36000
   Psfc = wrf_user_getvar(a,"PSFC",it)
   psfc = Psfc(j,i)
   p  = wrf_user_getvar(a,"p",it)
   p1 = p(0,53,78)
   p2 = p(0,53,74)
   p3 = p(0,49,78)
   p_adv = u1*(p2-p1)/36000 + v1*(p3-p1)/36000
   td  = wrf_user_getvar(a,"td",it)
   td1 = td(0,53,78)
   td12 = td(0,53,74)
   td3 = td(0,49,78)
   td_adv = u1*(td12-td1)/36000 + v1*(td3-td1)/36000
   qc1 = wrf_user_getvar(a,"QCLOUD",it)
   qc  = qc1(0,j,i)*1000

      write_table(file_name,"a",[/times(it),T2,TD2,T2_TD2,u,v,RH,psfc,qc/],"%s %f %f %f %f %f %f %f %f")
end do
