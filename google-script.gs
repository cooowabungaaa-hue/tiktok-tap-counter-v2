function doPost(e) {
  var sheet = SpreadsheetApp.getActiveSpreadsheet().getActiveSheet();
  var payload = JSON.parse(e.postData.contents);
  
  // タイムスタンプ, TikTokID
  var timestamp = payload.timestamp;
  var tiktokId = payload.username;
  var ranking = payload.ranking;
  
  // データを整形して追加
  // A列: タイムスタンプ, B列: TikTokID, C列: ユーザー名, D列: ユーザーユニークID, E列: タップ数
  ranking.forEach(function(viewer) {
    sheet.appendRow([
      timestamp,
      tiktokId,
      viewer.name,
      viewer.id,
      viewer.taps
    ]);
  });
  
  return ContentService.createTextOutput("Success");
}
