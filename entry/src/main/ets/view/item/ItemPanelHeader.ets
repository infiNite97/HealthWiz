@Component
export default struct ItemPanelHeader {
  build() {
    Row() {
      Text('2024年1月25号 早餐')
        .fontSize(16)
        .fontWeight(400)
      Image($r('app.media.ic_public_spinner'))
        .fillColor(Color.Gray)
        .width(20)
    }
    .width('94%')
    .justifyContent(FlexAlign.Center)
  }
}