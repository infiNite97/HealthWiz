import RecordPO from '../common/bean/RecordPO'
import DateUtil from '../common/utils/DateUtil'
import ItemModel from '../model/ItemModel'
import RecordModel from '../model/RecordModel'
import { RecordTypeEnum, RecordTypes } from '../model/RecordTypeModel'
import GroupInfo from '../viewmodel/GroupInfo'
import RecordType from '../viewmodel/RecordType'
import RecordVO from '../viewmodel/RecordVO'
import StatsInfo from '../viewmodel/StatsInfo'

class RecordService {
  insert(typeId: number, itemId: number, amount: number): Promise<number> {
    // 1.获取时间
    let createTime = (AppStorage.Get('selectedDate') || DateUtil.beginTimeOfDay(new Date())) as number
    // 2.新增
    return RecordModel.insert({ typeId, itemId, amount, createTime })
  }

  deleteById(id: number) {
    return RecordModel.deleteById(id)
  }

  async queryRecordByDate(date: number): Promise<RecordVO[]> {
    // 查询数据库RecordPO
    let rps = await RecordModel.listByDate(date)
    // 将RecordPO转为RecordVO
    return rps.map(rp => {
      let rv = { id: rp.id, typeId: rp.typeId, amount: rp.amount } as RecordVO

      rv.recordItem = ItemModel.getById(rp.itemId, rp.typeId !== RecordTypeEnum.WORKOUT)

      rv.calorie = rp.amount * rv.recordItem.calorie

      return rv
    })
  }

  calculateStatsInfo(records: RecordVO[]): StatsInfo {
    // 准备结果
    let info = new StatsInfo()
    if (!records || records.length <= 0) {
      return info
    }
    // 计算统计数据
    records.forEach(r => {
      if (r.typeId === RecordTypeEnum.WORKOUT) {
        // 运动:累加消耗热量
        info.expend += r.calorie
      } else {
        // 食物:累加摄入热量，蛋白质，碳水，脂肪
        info.intake += r.calorie
        info.protein += r.recordItem.protein
        info.carbon += r.recordItem.carbon
        info.fat += r.recordItem.fat
      }
    })

    return info

  }

  calculateGroupInfo(records: RecordVO[]): GroupInfo<RecordType, RecordVO>[] {
    // 创建空的记录类型分组
    let groups = RecordTypes.map(recordType => new GroupInfo(recordType, []))
    if (!records || records.length <= 0) {
      return groups
    }
    // 遍历饮食记录
    records.forEach(record => {
      groups[record.typeId].items.push(record)
      groups[record.typeId].calorie += record.calorie
    })
    return groups
  }


}

let recordService = new RecordService()

export default recordService as RecordService