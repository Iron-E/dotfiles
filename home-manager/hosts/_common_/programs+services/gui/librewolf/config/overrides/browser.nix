{ lib, outputs, ... }:
let
  inherit (builtins) toJSON;
  inherit (lib) flip pipe;

  addons =
    mapFn:
    flip pipe [
      (map mapFn)
      toJSON
    ];

  util = outputs.lib;
in
{
  imports = [ ];

  programs.librewolf.settings = lib.mapAttrs' (n: lib.nameValuePair "browser.${n}") {
    "compactmode.show" = true;
    "contentblocking.category" = "strict";
    "display.use_document_fonts" = 0;
    "download.panel.shown" = true;
    "engagement.ctrlTab.has-used" = true;
    "engagement.downloads-button.has-used" = true;
    "engagement.library-button.has-used" = true;
    "geo.enabled" = false;
    "newtabpage.activity-stream.improvesearch.handoffToAwesomebar" = true;
    "newtabpage.storageVersion" = 1;
    "policies.runOncePerModification.removeSearchEngines" = toJSON [
      "Google"
      "Bing"
      "Amazon.com"
      "eBay"
      "Twitter"
    ];
    "protections_panel.infoMessage.seen" = true;
    "proton.enabled" = true;
    "proton.places-tooltip.enabled" = true;
    "region.local-geocoding" = false;
    "region.network.url" = "";
    "region.update.enabled" = false;
    "safebrowsing.downloads.enabled" = false;
    "safebrowsing.downloads.remote.block_potentially_unwanted" = false;
    "safebrowsing.downloads.remote.block_uncommon" = false;
    "safebrowsing.downloads.remote.enabled" = false;
    "safebrowsing.malware.enabled" = false;
    "safebrowsing.phishing.enabled" = false;
    "tabs.cardPreview.enabled" = true;
    "tabs.inTitlebar" = 0;
    "theme.content-theme" = 0;
    "theme.toolbar-theme" = 0;
    "urlbar.clipboard.featureGate" = true;
    "urlbar.shortcuts.quickactions" = true;
    "urlbar.suggest.calculator" = true;
    "urlbar.suggest.engines" = false;
    "urlbar.suggest.openpage" = false;
    "urlbar.suggest.quicksuggest.sponsored" = false;
    "urlbar.suggest.topsites" = false;
    "urlbar.switchTabs.searchAllContainers" = true;

    "policies.runOncePerModification.extensionsInstall" =
      addons (name: "https://addons.mozilla.org/firefox/downloads/latest/${name}/latest.xpi")
        [
          "canvasblocker"
          "contain-amazon"
          "decentraleyes"
          "facebook-container"
          "google-container"
          "temporary-containers"
          "ublock-origin"
        ];

    "policies.runOncePerModification.extensionsUninstall" = addons (ext: "${ext}@search.mozilla.org") [
      "amazondotcom"
      "bing"
      "ebay"
      "google"
      "twitter"
    ];

    "uiCustomization.state" = toJSON (
      util.attrsets.pair "placements" {
        "PersonalToolbar" = [ "personal-bookmarks" ];
        "TabsToolbar" = [
          "tabbrowser-tabs"
          "new-tab-button"
          "alltabs-button"
        ];
        "toolbar-menubar" = [ "menubar-items" ];
        "unified-extensions-area" = [ "canvasblocker_kkapsner_de-browser-action" ];
        "widget-overflow-fixed-list" = [ ];

        "nav-bar" = [
          "back-button"
          "forward-button"
          "stop-reload-button"
          "customizableui-special-spring1"
          "urlbar-container"
          "customizableui-special-spring2"
          "save-to-pocket-button"
          "addon_darkreader_org-browser-action"
          "ublock0_raymondhill_net-browser-action"
          "downloads-button"
          "library-button"
          "fxa-toolbar-menu-button"
          "unified-extensions-button"
          "reset-pbm-toolbar-button"
        ];
      }
    );
  };
}
