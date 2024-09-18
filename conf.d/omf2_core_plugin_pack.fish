# Support Fisher's plugin events

function _omf2
    if not type -q omf2
        functions -e omf2
        fisher install omf2/omf2
    end
    omf2 $argv
end

function _omf2_core_plugin_pack_install --on-event omf2_core_plugin_pack_install
    _omf2 fisher-event install omf2/core-plugin-pack
end

function _omf2_core_plugin_pack_update --on-event omf2_core_plugin_pack_update
    _omf2 fisher-event update omf2/core-plugin-pack
end

function _omf2_core_plugin_pack_uninstall --on-event omf2_core_plugin_pack_uninstall
    _omf2 fisher-event uninstall omf2/core-plugin-pack
end
