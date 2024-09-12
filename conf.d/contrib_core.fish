# Support Fisher's plugin events
if not type -q omf2
    function omf2
        functions -e omf2
        fisher install oh-my-fish-2/omf2
        omf2 $argv
    end
end

function _contrib_core_install --on-event contrib_core_install
    omf2 fisher-event install oh-my-fish-2/contrib-core
end

function _contrib_core_update --on-event contrib_core_update
    omf2 fisher-event update oh-my-fish-2/contrib-core
end

function _contrib_core_uninstall --on-event contrib_core_uninstall
    omf2 fisher-event uninstall oh-my-fish-2/contrib-core
end
