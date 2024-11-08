import pageOneTmp from './toolList/PageOne'

@Entry
@Component
struct Index {
  @State TooTmp: ToolbarItem = {'value': "func", 'icon': "./image/ic_public_highlights.svg", 'action': ()=> {}}

  private toolList = [
    '加解密编码', // MD5 base65 ...
    '今天吃什么',
    '体脂计算器',
    '电话模拟器',
    '关系计算器',
    '功德木鱼',
  ]


  @Provide('pageInfos') pageInfos: NavPathStack = new NavPathStack()

  @Builder
  PageMap(name: string) {
    if (name === "NavDestinationTitle1") {
      pageOneTmp()
    } else if (name === "NavDestinationTitle2") {
      pageTwoTmp()
    } else if (name === "NavDestinationTitle3") {
      pageThreeTmp()
    }
  }

  build() {
    Column() {
      Navigation(this.pageInfos) {
        List({ space: 12 }) {
          ForEach(this.toolList, (item:string) => {
            ListItem() {
              Text(item)
                .width("100%")
                .height(72)
                .backgroundColor('#F1F3F5')
                .borderRadius(24)
                .fontSize(16)
                .fontWeight(500)
                .textAlign(TextAlign.Center)
                .onClick(()=>{
                  this.pageInfos.pushPath({ name: "NavDestinationTitle" + 1})
                })
            }
          }, (item:string) => item.toString())
        }
        .scrollBarWidth(0)
        .width("100%")
        .padding({
          left: '5%',
          right: '5%'
        })
        .margin({ top: 12 })

      }
      .title("Yo 工具箱")
      .navDestination(this.PageMap) // 子页面
      .titleMode(NavigationTitleMode.Mini)
      .hideBackButton(true)
      .menus([ // 顶部菜单栏
        {value: "列表", icon: '/common/images/list.svg', action: ()=> {}},
        {value: "宫格", icon: '/common/images/grid.svg', action: ()=> {}},
        {value: "设置", icon: '/common/images/edit.svg', action: ()=> {}},
      ])
    }
    .height('100%')
    .width('100%')
  }
}




// PageTwo.ets
@Component
export struct pageTwoTmp {
  @Consume('pageInfos') pageInfos: NavPathStack;
  build() {
    NavDestination() {
      Column() {
        Text("NavDestinationContent2")
      }.width('100%').height('100%')
    }.title("NavDestinationTitle2")
    .onBackPressed(() => {
      const popDestinationInfo = this.pageInfos.pop() // 弹出路由栈栈顶元素
      console.log('pop' + '返回值' + JSON.stringify(popDestinationInfo))
      return true
    })
  }
}

// PageThree.ets
@Component
export struct pageThreeTmp {
  @Consume('pageInfos') pageInfos: NavPathStack;
  build() {
    NavDestination() {
      Column() {
        Text("NavDestinationContent3")
      }.width('100%').height('100%')
    }.title("NavDestinationTitle3")
    .onBackPressed(() => {
      const popDestinationInfo = this.pageInfos.pop() // 弹出路由栈栈顶元素
      console.log('pop' + '返回值' + JSON.stringify(popDestinationInfo))
      return true
    })
  }
}