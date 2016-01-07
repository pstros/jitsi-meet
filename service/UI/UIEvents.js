var UIEvents = {
    NICKNAME_CHANGED: "UI.nickname_changed",
    SELECTED_ENDPOINT: "UI.selected_endpoint",
    PINNED_ENDPOINT: "UI.pinned_endpoint",
    LASTN_CHANGED: "UIEvents.lastn_changed",
    LARGEVIDEO_INIT: "UI.largevideo_init",
    /**
     * Notifies interested parties when the film strip (remote video's panel)
     * is hidden (toggled) or shown (un-toggled).
     */
    FILM_STRIP_TOGGLED: "UI.filmstrip_toggled"
};
module.exports = UIEvents;