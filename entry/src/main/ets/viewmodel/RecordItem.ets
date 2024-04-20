// 饮食记录中的记录项，可以是食物或运动
export default class RecordItem {
  id: number
  name: ResourceStr
  image: ResourceStr
  categoryId: number
  calorie: number
  unit: ResourceStr
  carbon: number
  protein: number
  fat: number

  constructor(id: number, name: ResourceStr, image: ResourceStr,
              categoryId: number, unit: ResourceStr, calorie: number,
              carbon: number = 0, protein: number = 0, fat: number = 0) {
    this.id = id
    this.name = name
    this.image = image
    this.categoryId = categoryId
    this.unit = unit
    this.calorie = calorie
    this.protein = protein
    this.fat = fat
    this.carbon = carbon
  }
}