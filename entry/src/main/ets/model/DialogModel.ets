import relationalStore from '@ohos.data.relationalStore'
import { MsgInput } from '../view/ai/WenxinAI'

// 对话存储数据库
class DialogModel {
  private rdbStore: relationalStore.RdbStore
  private tableName: string = 'DIALOG'

  // 数据库初始化
  initDialogDB(context) {

    const config = {
      name: 'AIDialog.db',
      securityLevel: relationalStore.SecurityLevel.S1
    }

    const sql = `CREATE TABLE IF NOT EXISTS DIALOG
                 (
                  ID INTEGER PRIMARY KEY AUTOINCREMENT,
                  ROLE TEXT NOT NULL,
                  CONTENT TEXT NOT NULL
                 )`
    relationalStore.getRdbStore(context, config, (err, rdbStore) => {
      if (err) {
        console.log('testTag', '获取rdbStore失败！')
        return
      }
      rdbStore.executeSql(sql)
      console.log('testTag', '创建Dialog表成功！')

      this.rdbStore = rdbStore
    })

  }

  // 数据库读取数据
  async getDialogDB() {

    let predicates = new relationalStore.RdbPredicates(this.tableName)
    let result = await this.rdbStore.query(predicates, ['ID', 'ROLE', 'CONTENT'])
    let Dialogs: MsgInput[] = []

    while (!result.isAtLastRow) {
      result.goToNextRow()

      let id = result.getLong(result.getColumnIndex('ID'))
      let role = result.getString(result.getColumnIndex('ROLE'))
      let content = result.getString(result.getColumnIndex('CONTENT'))

      Dialogs.push({ id, role, content })
    }
    return Dialogs

  }

  // 数据库存储数据
  putDialogDB(id: number, role: string, content: string) {
    return this.rdbStore.insert(this.tableName, { id, role, content })
  }

  //TODO 数据库更新数据(暂无需求)
  updateDialogDB() {

  }

  // 数据库删除数据
  deleteDialogDB(id: number) {
    let predicates = new relationalStore.RdbPredicates(this.tableName)
    predicates.equalTo('ID', id)
    return this.rdbStore.delete(predicates)
  }
}

let dialogModel = new DialogModel()

export default dialogModel as DialogModel

