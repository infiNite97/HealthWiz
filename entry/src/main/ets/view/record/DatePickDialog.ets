@CustomDialog
export default struct DatePickDialog {
  controller: CustomDialogController
  selectedDate: Date = new Date()

  build() {
    Column() {
      // 日期选择器
      DatePicker({
        start: new Date('2022-01-01'),
        end: new Date(),
        selected: this.selectedDate
      })
        .padding({bottom:20,top:20})
        .onChange((value: DatePickerResult) => {
          this.selectedDate.setFullYear(value.year, value.month, value.day)
        })
      // 按钮
      Row({ space: 12 }) {
        Button('取消')
          .width(120)
          .backgroundColor($r('app.color.light_gray'))
          .onClick(() => {
            this.controller.close()
          })
        Button('确定')
          .width(120)
          .backgroundColor($r('app.color.primary_color'))
          .onClick(() => {
            AppStorage.SetOrCreate('selectedDate', this.selectedDate.getTime())
            this.controller.close()
          })
      }
    }
    .padding(12)
  }
}

