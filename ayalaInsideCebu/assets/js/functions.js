/* 検索フォーム（where） */
function sendDate($startVal, $goalVal) {
    window.location =　'scheme://saveFunc?start=' + $startVal + '&goal=' + $goalVal;
}

/* グロナビ */
function movePage($pageType) {
	window.location =　'scheme://saveFunc?page=' + $pageType;
}

/* ショップID */
function getShopID($id) {
	window.location =　'scheme://saveFunc?id=' + $id;
}
