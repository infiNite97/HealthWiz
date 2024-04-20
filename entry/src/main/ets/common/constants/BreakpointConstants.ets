export default class BreakpointConstants {
  // 小屏幕Breakpoint标记
  static readonly BREAKPOINT_SM: string = 'sm'
  // 中屏幕Breakpoint标记
  static readonly BREAKPOINT_MD: string = 'md'
  // 大屏幕Breakpoint标记
  static readonly BREAKPOINT_LG: string = 'lg'
  // 当前设备的Breakpoint 存储key
  static readonly CURRENT_BREAKPOINT: string = 'currentBreakpoint'
  // 小屏幕设备宽度
  static readonly RANGE_SM: string = '(320vp<=width<600)'
  // 中屏幕设备宽度
  static readonly RANGE_MD: string = '(600vp<=width<840)'
  // 大屏幕设备宽度
  static readonly RANGE_LG: string = '(840vp<=width)'
}