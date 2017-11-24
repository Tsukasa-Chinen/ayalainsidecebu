/*
function sendDate() {
    window.location =　'scheme://saveFunc?page=map';
}
*/
function sendDate($startVal, $goalVal) {
    window.location =　'scheme://saveFunc?start=' + $startVal + '&goal=' + $goalVal;
}
