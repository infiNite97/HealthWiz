import ItemCategory from '../viewmodel/ItemCategory'

/**
 * 食物类型的枚举
 */
enum FoodCategoryEnum {
  /**
   * 主食
   */
  STAPLE,
  /**
   * 蔬果
   */
  FRUIT,
  /**
   * 肉蛋奶
   */
  MEAT,
  /**
   * 坚果
   */
  NUT,
  /**
   * 其它
   */
  OTHER,
}

/**
 * 食物类型数组
 */
let FoodCategories = [
  new ItemCategory(0, $r('app.string.staple')),
  new ItemCategory(1, $r('app.string.fruit')),
  new ItemCategory(2, $r('app.string.meat')),
  new ItemCategory(3, $r('app.string.nut')),
  new ItemCategory(4, $r('app.string.other_type')),
]

/**
 * 运动类型枚举
 */
enum WorkoutCategoryEnum {
  /**
   * 下肢
   */
  LOWLIMBS,
  /**
   * 手臂
   */
  ARMS,
  /**
   * 躯干
   */
  BODY,
  /**
   * 全身
   */
  WHOLE
}

/**
 * 运动类型数组
 */
let WorkoutCategories = [
  new ItemCategory(0, $r('app.string.lowlimbs')),
  new ItemCategory(1, $r('app.string.arms')),
  new ItemCategory(2, $r('app.string.body')),
  new ItemCategory(3, $r('app.string.whole'))
]

export { FoodCategories, WorkoutCategories, FoodCategoryEnum, WorkoutCategoryEnum }