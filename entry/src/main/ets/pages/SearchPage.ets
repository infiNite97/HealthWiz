import router from '@ohos.router'

@Entry
@Component
struct SearchPage {
  val: string = router.getParams()['val']

  build() {
    Row({ space: 8 }) {
      Search({ value: this.val })
        .textFont({ size: 18 })
        .layoutWeight(1)
        .copyOption(CopyOptions.LocalDevice)

    }
    .width('90%')
  }
}