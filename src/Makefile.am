
.NOTPARALLEL :

EXTRA_DIST  = ParserExpressionsGlobals.hs Parser.hs ParserExpressions.hs ParserUntil.hs

if HAVE_HASHMAP
bin_PROGRAMS = scoop
endif

BUILT_SOURCES  = ParserExpressionsGlobals.hs
BUILT_SOURCES += ParserExpressions.hs
BUILT_SOURCES += ParserUntil.hs
BUILT_SOURCES += Parser.hs

GHC_SCOOP = -O -XBangPatterns -outputdir. -i${top_srcdir}/src
GHC_SCOOP_STATIC = $(GHC_SCOOP)
GHC_SCOOP_SHARED = -osuf dyn_o -hisuf dyn_hi -dynamic -fPIC $(GHC_SCOOP)

.PHONY: scoop libscoop.so

scoop:
	ghc --make $(GHC_SCOOP_STATIC) -o scoop ${top_srcdir}/src/scoop.hs

%.hs: %.y
	happy -o $@ $<

#%.o: %.hs
#	ghc -c -O -o $@ $<

clean::
	$(RM) scoop libscoop.so $(BUILT_SOURCES) *.hi *.o *.dyn_hi *.dyn_o

libscoop.so: LibScoop.hs lib_scoop.c
	ghc --make $(GHC_SCOOP_SHARED) -c ${top_srcdir}/src/LibScoop.hs
	ghc $(GHC_SCOOP_SHARED) -optc-O -optc-std=c99 -I. -I${top_srcdir}/src -o lib_scoop.o -c ${top_srcdir}/src/lib_scoop.c
	if test -f  LibScoop_stub.c ; then \
		ghc --make $(GHC_SCOOP_SHARED) -shared -L$(GHC_LIBDIR) ${top_srcdir}/src/LibScoop.hs -o libscoop.so LibScoop_stub.dyn_o lib_scoop.o -lffi -lHSrts_thr-$(GHC_VERSION) ; \
	else \
		ghc --make $(GHC_SCOOP_SHARED) -shared -L$(GHC_LIBDIR) ${top_srcdir}/src/LibScoop.hs -o libscoop.so lib_scoop.o -lffi -lHSrts_thr-$(GHC_VERSION); \
	fi

all-local: libscoop.so

install-exec-local: libscoop.so
	$(INSTALL) libscoop.so $(DESTDIR)$(libdir)/libscoop.so

