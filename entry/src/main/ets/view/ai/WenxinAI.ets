import http from '@ohos.net.http'
import { WindowMode } from '@ohos.UiTest'
import DialogModel from '../../model/DialogModel'

// 文心一言返回体
class WenXinReturn {
  id: string = ""
  object: string = ""
  created: string = ""
  result: string = ""
  is_truncated: Boolean = false
  need_clear_history: Boolean = false
  finish_reason: string = ""
  usage: Usage = new Usage()
}

class Usage {
  prompt_tokens: number = 0
  completion_tokens: number = 0
  total_tokens: number = 0
}

class MsgOutput {
  content: string = ""
}

export class MsgInput {
  id: number = 0
  role: string = ""
  content: string = ""
}

@Component
export default struct WenxinAI {
  @State message: string = ''
  @State WXReturn: WenXinReturn = new WenXinReturn()
  @State MsgResult: MsgOutput = new MsgOutput()
  @State MsgInputSample: MsgInput = new MsgInput()
  @State MsgArray: MsgInput[] = []
  @State pleaseHolder: string = ''
  @State deleteIndex: number = 0
  @State isLoading: boolean = false
  @State loadDialog: boolean = false
  scroller: Scroller = new Scroller()

  aboutToAppear() {

    // 每次启动查询之前的对话记录
    DialogModel.getDialogDB()
      .then((Dialogs) => {
        this.MsgArray = Dialogs
        this.loadDialog = true
        console.log('testTag', '查询到数据:', this.MsgArray.length, JSON.stringify(this.MsgArray))
      })
      .catch((err) => {
        console.log('testTag', '查询失败:', JSON.stringify(err))
      })

    // 如果是第一次对话则对话框显示预留语句
    setTimeout(() => {
      if (this.MsgArray.length == 0) {
        this.message = "你好！健康小助手"
      }
    }, 100)

    //对话条数超过300条时删掉先前的对话
    if (this.MsgArray.length > 300) {
      for (let i = 0; i < this.MsgArray.length - 300; i++) {
        DialogModel.deleteDialogDB(this.deleteIndex)
        this.deleteIndex++
      }
    }
  }

  //构造Http发送请求
  sendHttpRequest(url, method, headers, data): Promise<http.HttpResponse> {
    return new Promise((resolve, reject) => {
      let httpRequest = http.createHttp()
      httpRequest.request(url, {
        method: method,
        header: headers,
        extraData: data
      }, (err, data) => {
        if (!err) {
          resolve(data) // 请求成功，使用resolve返回数据
        } else {
          reject(err) // 请求失败，使用reject返回错误
        }
        httpRequest.destroy() // 请求完成后销毁请求对象
      })
    })
  }

  // 发送Http请求
  async httpData(MsgArray: Array<MsgInput>) {

    this.showLoadingIndicator() // 显示加载提示

    try {
      const responseData = await this.sendHttpRequest(
        "https://aip.baidubce.com/rpc/2.0/ai_custom/v1/wenxinworkshop/chat/completions?access_token=24.eef66166f034ece760572f139967312d.2592000.1715270467.282335-60592984",
        http.RequestMethod.POST,
        [{ 'Content-Type': 'application/json' }],
        { "messages": MsgArray }
      )

      // 处理Http应答
      let MsgReturn: WenXinReturn = JSON.parse(responseData.result.toString())
      this.MsgResult.content = MsgReturn.result
      let MsgIn: MsgInput = new MsgInput()
      MsgIn.role = "assistant"
      MsgIn.content = this.MsgResult.content
      MsgIn.id = this.MsgArray.length
      this.MsgArray.push(MsgIn)
      // 隐藏加载提示，显示处理完成的状态
      this.hideLoadingIndicator()
    } catch (error) {

      this.message = JSON.stringify(error)
      console.error('error:' + JSON.stringify(error))
    }
  }

  // 显示加载中
  showLoadingIndicator() {
    this.isLoading = true

  }

  hideLoadingIndicator() {
    if (this.MsgArray.length >= 2) {
      // 获取最后两个元素的索引
      const lastIndex = this.MsgArray.length - 1
      const secondLastIndex = lastIndex - 1
      // 将一组对话存入数据库
      DialogModel.putDialogDB(this.MsgArray[secondLastIndex].id, this.MsgArray[secondLastIndex].role, this.MsgArray[secondLastIndex].content)
      DialogModel.putDialogDB(this.MsgArray[lastIndex].id, this.MsgArray[lastIndex].role, this.MsgArray[lastIndex].content)
      console.log('testTag', '成功存入Dialog数据', this.MsgArray[secondLastIndex].id, this.MsgArray[secondLastIndex].role, this.MsgArray[secondLastIndex].content, this.MsgArray[lastIndex].id, this.MsgArray[lastIndex].role, this.MsgArray[lastIndex].content)

    }

    this.isLoading = false
    // 产生新的对话时划到最底
    setTimeout(() => {
      this.scroller.scrollEdge(Edge.End)
    }, 300)
  }

  build() {
    Column() {
      Column() {
        // 健康小助手头部
        Row() {
          Image($r('app.media.healthyhelper'))
            .width(24)
            .fillColor("#EDEDED")
            .margin({ right: 8 })
          Text('健康小助手')
        }
        .width('100%')
        .justifyContent(FlexAlign.Center)
        .height(60)

        // 健康小助手对话框
        Scroll(this.scroller) {
          Column() {
            ForEach(this.MsgArray, (item: MsgInput, index: number) => {
              if (item.role == "user") {
                Row() {
                  Text(item.content)
                    .padding(15.5)
                    .backgroundColor($r('app.color.light_primary_color'))
                    .borderRadius({ topLeft: 20, topRight: 20, bottomLeft: 20 })
                    .textAlign(TextAlign.End)
                }
                .margin({ top: index === 0 ? 0 : 12 })
                .width("100%")
                .alignItems(VerticalAlign.Top)
                .justifyContent(FlexAlign.End)
                .padding({ left: 10, right: 10 })
              } else if (item.role == "assistant") {
                Row() {
                  Text(item.content)
                    .padding(15.5)
                    .backgroundColor(Color.White)
                    .borderRadius({ topLeft: 20, topRight: 20, bottomRight: 20 })

                }
                .margin({ top: index === 0 ? 0 : 12 })
                .width("100%")
                .alignItems(VerticalAlign.Top)
                .justifyContent(FlexAlign.Start)
                .padding({ left: 10, right: 10 })
              }
            })
          }
          .padding({ top: 12, bottom: 12 })
        }
        .width("100%")
        .margin({ bottom: 70 })

      }
      .layoutWeight(1)

      // 健康小助手输入框
      Stack() {

        Row() {
          TextInput({
            placeholder: this.pleaseHolder, text: this.message
          })
            .backgroundColor(Color.White)
            .layoutWeight(1)
            .padding({ left: 8 })
            .height(50)
            .onChange((msg: string) => {
              this.message = msg
            })
            .margin({ top: 10, bottom: 10, left: 10, right: 4 })
          Image($r('app.media.ic_public_send_filled'))
            .width(35)
            .margin({ left: 8, right: 5 })
            .fillColor($r('app.color.primary_color'))
            .onClick(() => {
              if (!this.isLoading) {
                let MsgIn: MsgInput = new MsgInput()
                MsgIn.id = this.MsgArray.length
                MsgIn.role = "user"
                MsgIn.content = this.message.replace(/[*]/g, ' ')
                this.MsgArray.push(MsgIn)
                this.httpData(this.MsgArray)
                this.message = ""
              }
            })
        }
        .borderRadius({ topLeft: 10, topRight: 10 })
        .backgroundColor("#F7F7F7")
        .width('100%')

        if (this.isLoading) {
          LoadingProgress()
            .width(60)
            .height(60)
        }
      }
    }
    .width("100%")
    .height("100%")
    .justifyContent(FlexAlign.SpaceBetween)
    .backgroundColor("#EDEDED")
  }
}
