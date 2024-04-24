import RecordType from '../viewmodel/RecordType'

enum RecordTypeEnum {
  /**
   * 早餐
   */
  BREAKFAST,
  /**
   * 午餐
   */
  LUNCH,
  /**
   * 晚餐
   */
  DINNER,
  /**
   * 加餐
   */
  EXTRA_MEAL,
  /**
   * 运动
   */
  WORKOUT
}

/**
 * 记录类型常量
 */
const RecordTypes: RecordType[] = [
  new RecordType(0, $r("app.string.breakfast"), $r("app.media.zaocan"), 423, 592),
  new RecordType(1, $r("app.string.lunch"), $r("app.media.wucan"), 592, 761),
  new RecordType(2, $r("app.string.dinner"), $r("app.media.wancan"), 423, 592),
  new RecordType(3, $r("app.string.extra_meal"), $r("app.media.ic_extra_m"), 0, 169),
  new RecordType(4, $r("app.string.workout"), $r("app.media.yundong")),
]

export { RecordTypes, RecordTypeEnum }