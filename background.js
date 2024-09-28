


let button_id = "sun-button";

chrome.contextMenus.removeAll(function() {
	chrome.contextMenus.create({
		id: button_id,
		title: "Download",
		contexts: ["all"],
	});
});

function on_click(info, tab) {
	// console.log('==================================================');
	if (info.menuItemId !== button_id) throw {info, tab};
	
	console.log({info, tab});
	
	let url = info.linkUrl ?? info.frameUrl ?? info.srcUrl ?? tab.url;
	// console.log(url);
	
	let port = chrome.runtime.connectNative('com.sunorg.sunbutton_host');
	
	port.onMessage.addListener(function (msg) {
		// console.log('Received event: ' + msg);
		if (msg !== 'Done') throw msg;
		port.disconnect();
		// console.log('Manually disconnected');
	});
	
	port.onDisconnect.addListener(function () {
		// console.log('Disconnected event');
	});
	
	port.postMessage(url);
	// console.log('Posted');
	
}

chrome.contextMenus.onClicked.addListener(on_click);


