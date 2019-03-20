EXTRA_DIST = \
	$(srcdir)/Arc-Kde \
	$(srcdir)/COPYING \
	$(srcdir)/CREDITS \
	$(srcdir)/README.md

themedir = $(datadir)/icons

install-data-hook:
	test -d $(DESTDIR)$(themedir) || $(MKDIR_P) $(DESTDIR)$(themedir)
	cp -Rv $(srcdir)/Arc-Kde $(DESTDIR)$(themedir)/.

uninstall-hook:
	test -d $(DESTDIR)$(themedir)/Arc-Kde && rm -rf $(DESTDIR)$(themedir)/Arc-Kde
