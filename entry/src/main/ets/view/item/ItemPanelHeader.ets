@Component
export default struct ItemPanelHeader {
  build() {
    Row() {
      Text('2024年1月25号 早餐')
        .fontSize(18)
        .fontWeight(600)
      Image($r('app.media.ic_public_spinner'))
        .fillColor(Color.Black)
        .width(20)
    }
    .width('94%')
    .justifyContent(FlexAlign.Center)
  }
}