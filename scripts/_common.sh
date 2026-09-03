#!/bin/bash

# Common helpers and package-wide variables.
app_root="${install_dir:-/var/www/$app}"

# Ditto is configured through a build-time ditto.json file (see its own
# README's "Configuration" section) - deliberately not generated here.
# DittoConfigSchema wraps every field as optional (a missing ditto.json is
# handled gracefully - loadDittoConfig() in vite.config.ts just returns
# undefined), but several of its nested schemas (e.g. RelayMetadataSchema)
# require fields beyond what a simple install-time question would supply
# (an `updatedAt` timestamp, for one) - so a hand-rolled config file risks
# a subtly-invalid schema. `npm run build` with no ditto.json at all uses
# Ditto's own hardcoded defaults, which is what's shipped here; exposing
# real customization (relays, branding, ...) via this package's own config
# panel is a reasonable follow-up, not attempted in this first version.
build_ditto() {
	pushd "$app_root" >/dev/null
	npm run build
	popd >/dev/null
	chown -R www-data: "$app_root"
}
