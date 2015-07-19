function loadMenu() {
    console.log( "ready!" );
    $("#menu-close").click(function(e) {
        e.preventDefault()
        console.log("close menu");
        $("#sidebar-wrapper").toggleClass("active");
    });

    // Opens the sidebar menu
    $("#menu-toggle").click(function(e) {
        e.preventDefault();
        console.log("open menu");
        $("#sidebar-wrapper").toggleClass("active");
    });
}

