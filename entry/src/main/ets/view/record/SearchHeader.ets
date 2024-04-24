import router from '@ohos.router'

@Preview
@Component
export default struct SearchHeader {
  build() {
    Row({ space: 8 }) {
      Search({ placeholder: '搜索饮食或运动信息' })
        .textFont({ size: 18 })
        .layoutWeight(1)
        .copyOption(CopyOptions.LocalDevice)
        .searchButton('搜索')
        .onSubmit((val) => {
          router.pushUrl({
            url: 'pages/SearchPage',
            params: { val: val }
          })
        })
    }
    .width('90%')
  }
}