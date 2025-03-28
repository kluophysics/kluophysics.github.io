
      ELSEIF ((XC%ID(IXC)==ID_XC_SCANL).OR. &
              (XC%ID(IXC)==ID_XC_RSCANL).OR. &
              (XC%ID(IXC)==ID_XC_R2SCANL).OR. &
              (XC%ID(IXC)==ID_XC_OFR2)) THEN
        call scan_orb_free_xc(rhoup,rhodw,absnabup,absnabdw,absnab, &
        &  LAPLUP,LAPLDW,EXC_TMP,dEXCdRHOup_TMP,dEXCdRHOdw_TMP,dEXCdABSNABup_TMP,dEXCdABSNABdw_TMP, &
        &  dEXCdABSNAB_TMP,dEXCdLAPup_TMP,dEXCdLAPdw_TMP,XC%ID(IXC),XC%AMGGAX,XC%AMGGAC)
      ELSEIF (XC%ID(IXC)==ID_XC_SREGTM2L) THEN



      subroutine pc_tau_unp(pars,n,gn,ln,tau,dtdn,dtdgn,dtdln)
!$ACC ROUTINE SEQ

 Most important!!!!!!!!!





      subroutine pcrepmgga(d,dthrd,s,qq,tau,taud,taudd,taudl)
!$ACC ROUTINE SEQ
!     Perdew & Constantin kinetic energy functional enhancement factor
!     Written by:


      SUBROUTINE ts_pcrep(rho, p, ql, dfsdp, dfsdq, fs)
!$ACC ROUTINE SEQ
!     Perdew & Constantin kinetic energy functional enhancement factor



      SUBROUTINE V1SRTMx(RX,DRX,TAUX,Ex,VXD,VXDD,AMUXD)
!$ACC ROUTINE SEQ
!     Simplified regularized Tao-Mo variant 1 (v1-sregTM)
!     Functional (Exchange part only)


      SUBROUTINE V2SRTMx(RX,DRX,TAUX,Ex,VXD,VXDD,AMUXD)
!$ACC ROUTINE SEQ
!     Simplified regularized Tao-Mo variant 2 (v2-sregTM)
!     Functional (Exchange part only)


      SUBROUTINE V3SRTMx(RX,DRX,TAUX,Ex,VXD,VXDD,AMUXD)
!$ACC ROUTINE SEQ
!     Simplified regularized Tao-Mo variant 3 (v3-sregTM)
!     Functional (Exchange part only)

      SUBROUTINE VRTMc(RU,RD,DRT,TAUU,TAUD,Ec,VCD1,VCD2,VCDD,AMUCD1,AMUCD2)
!$ACC ROUTINE SEQ
!     Revised regularized Tao-Mo (rregTM)
!     Functional (Correlation part only)



         CALL CRTML(RS,ZETA,ECLDA,ECD1LDA,ECD2LDA,G,FK,S,EC,ECD1,ECD2,ECQ,TAUTOT,ECDT)
!$ACC ROUTINE SEQ
!     Deorbitalized revised regularized Tao-Mo-L (rregTM-L)
!     Functional (Correlation part only)


      SUBROUTINE XV2SRTML(RHO,RHOTHRD,S,QQ,EXLDA,EX,EXDLDA,EXD,EXDD,EXDL)
!$ACC ROUTINE SEQ
!     Deorbitalized Simplified regularized Tao-Mo-L variant 2 (v2-sregTM-L)
!     Functional (Exchange part only)