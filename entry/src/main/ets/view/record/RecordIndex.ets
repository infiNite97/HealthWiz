import SearchHeader from './SearchHeader'

@Component
export default struct RecordIndex {
  build() {
    Column(){


      // 头部搜索栏
      SearchHeader()
    }
    .width('100%')
    .height('100%')
    .backgroundColor($r('app.color.index_page_background'))
  }
}