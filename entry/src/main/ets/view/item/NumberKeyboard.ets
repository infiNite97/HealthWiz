@Component
export default struct NumberKeyboard {
  numbers: string[] = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9', '.']
  @Link amount: number
  @Link value: string

  @Styles
  keyBoxStyle(){
    .backgroundColor(Color.White)
    .height(60)
    .borderRadius(10)
  }

  build() {
    Grid() {
      ForEach(this.numbers, num => {
        GridItem() {
          Text(num)
            .fontSize(20)
            .fontWeight(900)
        }
        .keyBoxStyle()
        .onClick(() => {
          this.clickNumber(num)
        })
      })

      GridItem() {
        Text('删除')
          .fontSize(20)
          .fontWeight(900)
      }
      .keyBoxStyle()
      .onClick(() => {
        this.clickDelete()
      })

    }
    .width('100%')
    .height(300)
    .backgroundColor($r('app.color.index_page_background'))
    .columnsTemplate('1fr 1fr 1fr')
    .columnsGap(8)
    .rowsGap(8)
    .padding(8)
    .margin({ top: 10 })
  }

  clickNumber(num: string) {
    // 拼接字符串
    let val = this.value + num
    // 数据合理性校验
    let firstIndex = val.indexOf('.')
    let lastIndex = val.lastIndexOf('.')
    if (firstIndex !== lastIndex || (lastIndex != -1 && lastIndex < val.length - 2)) {
      // 非法输入
      return
    }
    let amount = this.parseFloat(val)

    if (amount >= 999.9) {
      this.amount = 999.0
      this.value = '999'
    } else {
      this.amount = amount
      this.value = val
    }

  }

  clickDelete() {
    if (this.value.length <= 0) {
      this.value = ''
      this.amount = 0
      return
    } else {
      this.value = this.value.substring(0, this.value.length - 1)
      this.amount = this.parseFloat(this.value)
    }
  }

  parseFloat(str: string) {
    if (!str) {
      return 0
    }
    if (str.endsWith('.')) {
      str = str.substring(0, str.length - 1)
    }
    return parseFloat(str)
  }
}