#
# Superchic 2 Makefile routine
#

# LHAPDF flags
LIBFLAG = LHAPDF
# Replace with location of LHAPDF on your system
LHAPDFLIB = ${LHAPDF_ROOT}/lib

# PDF input: Set to LHAPDF or USER
PDFINPUT     = 	LHAPDF
LHOPT        =  2

# Fortran compiler
FC = gfortran

#####################

HOME = $(PWD)
MAIN = $(PWD)/src/main
SOURCEDIR = $(PWD)/src
VPATH = $(DIRS)
INCPATH = $(SOURCEDIR)/inc

#####################

FFLAGS 	= -fno-automatic -fno-f2c -O2 -g  -I$(INCPATH)

#OUTPUT_OPTION = -o $(HOME)/obj/$@

DIRS	 =	$(SOURCEDIR)/int:\
		$(SOURCEDIR)/main:\
		$(SOURCEDIR)/mes:\
		$(SOURCEDIR)/PDFs:\
		$(SOURCEDIR)/phase:\
		$(SOURCEDIR)/sPDFs:\
		$(SOURCEDIR)/subamps:\
		$(SOURCEDIR)/surv:\
		$(SOURCEDIR)/EW:\
		$(SOURCEDIR)/unw:\
		$(SOURCEDIR)/user:\
		$(SOURCEDIR)/int:\
		$(SOURCEDIR)/var:\
		$(SOURCEDIR)/init:\

#############

Mesf = \
obj/calcmes.o \
obj/mesint.o \
obj/wfinit.o \
obj/wfoctet.o \
obj/wfsinglet.o \

PDFsfLHA = \
obj/alphas.o \
obj/inpdf.o \

PDFsfUSER = \
obj/alphasuser.o \
obj/inpdfuser.o \


Intf = \
obj/ran.o  \
obj/vegas.o \

Phasef = \
obj/2body.o \
obj/2bodyw.o \
obj/2jetps.o \
obj/2jetpsm.o \
obj/3jetps.o \
obj/boost.o \
obj/chic0decay3.o \
obj/chic1decay3.o \
obj/chic1decay2s.o \
obj/chic1decay2f.o \
obj/chic2decay3.o \
obj/chic2decay2s.o \
obj/chic2decay2f.o \
obj/jpsidecayphot.o \
obj/genpol1.o \
obj/genpol1rf.o \
obj/genpol2.o \
obj/rambo.o \
obj/6body.o \
obj/6bodyinit.o \
obj/4body.o \
obj/4bodyinit.o \
obj/3body.o \
obj/3bodyinit.o \
obj/2bodyinit.o \
obj/wwcorr.o \
obj/jpsidecay.o \
obj/rhodecay.o \
obj/chidecay.o \

Subampsf = \
obj/chi0.o \
obj/chi1.o \
obj/chi2.o \
obj/etaq.o \
obj/higgs.o \
obj/higgsinit.o \
obj/pipi.o \
obj/qqjets.o \
obj/diphoton.o \
obj/etaeta.o \
obj/etapetap.o \
obj/etaetap.o \
obj/eta.o \
obj/gggjets.o \
obj/pipixy.o \
obj/rhorho.o \
obj/djpsi.o \
obj/djpsip.o \
obj/djpsipp.o \
obj/ggjets.o \
obj/qqgjets.o \
obj/rhorhoxy.o \
obj/wwpol.o \
obj/llpol.o \
obj/mhv.o \
obj/lightlightpol.o \
obj/higgsgam.o \
obj/higgsgaminit.o \

Survf = \
obj/initparsr.o \
obj/formfac.o \
obj/formfacphot.o \
obj/formfacgam.o \
obj/seik.o \
obj/seikphot.o\
obj/seikgam.o \
obj/screeningint.o \
obj/readscreen.o \
obj/formfacgamel.o \

Userf = \
obj/cuts.o \
obj/histo.o \

Mainf = \
obj/bare.o \
obj/header.o \
obj/main.o \
obj/process.o \
obj/superchic.o \
obj/wtgen.o \

sPDFsf = \
obj/calchg.o \
obj/hpdfint.o \
obj/calcsud.o \
obj/sudint.o \
obj/sPDF.o \

Unwf = \
obj/unweight.o \
obj/unwprint.o \
obj/headerlhe.o \

Varf = \
obj/mu.o \
obj/nf.o \
obj/string.o \
obj/varfuncs.o \

InitfLHA = \
obj/alphas.o \
obj/init.o \
obj/initsud.o \
obj/nf.o \
obj/string.o \
obj/hg.o \
obj/inithg.o \
obj/initpars.o \
obj/calcop.o \
obj/calcscreen.o \
obj/opacityint.o \
obj/screeningint.o \
obj/screening.o \
obj/opacity.o \
obj/PDF.o \
obj/PDFlha.o \
obj/Sudakov.o \
obj/inpdf.o \

InitfUSER = \
obj/alphasuser.o \
obj/init.o \
obj/initsud.o \
obj/nf.o \
obj/string.o \
obj/hg.o \
obj/inithg.o \
obj/initpars.o \
obj/calcop.o \
obj/calcscreen.o \
obj/opacityint.o \
obj/screeningint.o \
obj/screening.o \
obj/opacity.o \
obj/PDF.o \
obj/PDFuser.o \
obj/Sudakov.o \
obj/inpdfuser.o \


iCODELHA = $(InitfLHA) \

sCODELHA = $(Mainf) $(Mesf) $(EW) $(PDFsfLHA) $(Intf) \
$(Phasef) $(Subampsf) $(Survf) $(Userf) \
$(sPDFsf) $(Unwf) $(Varf) \

iCODEUSER = $(InitfUSER) \

sCODEUSER = $(Mainf) $(Mesf) $(EW) $(PDFsfUSER) $(Intf) \
$(Phasef) $(Subampsf) $(Survf) $(Userf) \
$(sPDFsf) $(Unwf) $(Varf) \

all: init superchic

ifeq ($(PDFINPUT),LHAPDF)
ifeq ($(LHOPT),1)
init:	$(iCODELHA)
	$(FC) $(FFLAGS) -Wl,-R$(LHAPDFLIB) -L$(LHAPDFLIB) -l$(LIBFLAG) -o $@ \
	$(iCODELHA)  -l$(LIBFLAG)
	mv init bin/superchic_init
	@echo '    ----> Init compiled OK <----'

superchic: $(sCODELHA)
	$(FC) $(FFLAGS) -Wl,-R$(LHAPDFLIB) -L$(LHAPDFLIB) -o $@ \
	$(sCODELHA) -l$(LIBFLAG)
	mv superchic bin/superchic
	@echo '    ----> Superchicv2.04 compiled OK <----'
endif
ifeq ($(LHOPT),2)
init:	$(iCODELHA)
	$(FC) $(FFLAGS) -L$(LHAPDFLIB) -l$(LIBFLAG) -o $@ \
	$(iCODELHA)  -l$(LIBFLAG)
	mv init bin/superchic_init
	@echo '    ----> Init compiled OK <----'

superchic: $(sCODELHA)
	$(FC) $(FFLAGS) -L$(LHAPDFLIB) -o $@ \
	$(sCODELHA) -l$(LIBFLAG)
	mv superchic bin/superchic
	@echo '    ----> Superchicv2.04 compiled OK <----'
endif
endif

ifeq ($(PDFINPUT),USER)
init:	$(iCODEUSER)
	$(FC) $(FFLAGS)  -o $@ \
	$(iCODEUSER)
	mv init bin/superchic_init
	@echo '    ----> Init compiled OK <----'

superchic:	$(sCODEUSER)
	$(FC) $(FFLAGS)  -o $@ \
	$(sCODEUSER)
	mv superchic bin/superchic
	@echo '    ----> Superchicv2.04 compiled OK <----'
endif

.PHONY: install
install: bin/superchic_init bin/superchic
	install bin/superchic_init bin/superchic ${INSTALLROOT}/bin

clean:
	-rm -f $(HOME)/obj/*.o
