// 记录项类型

export default class ItemCategory {
  id: number
  name: ResourceStr

  constructor(id: number, name: ResourceStr) {
    this.id = id
    this.name = name
  }
}
