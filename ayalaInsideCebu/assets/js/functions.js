/* 検索フォーム（where） */
function sendDate($startVal, $goalVal) {
    window.location =　'scheme://func?start=' + $startVal + '&goal=' + $goalVal;
}

/* グロナビ */
function movePage($pageType) {
	window.location =　'scheme://func?page=' + $pageType;
}

/* ショップID, フロア */
function sendShopInfo($id, $floor) {
	window.location =　'scheme://func?shop_id=' + $id + '&shop_floor=' + $floor;
}
