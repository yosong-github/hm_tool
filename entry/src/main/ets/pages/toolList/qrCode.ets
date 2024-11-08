import { photoAccessHelper } from '@kit.MediaLibraryKit';
import { BusinessError } from '@kit.BasicServicesKit';

let PhotoSelectOptions = new photoAccessHelper.PhotoSelectOptions();
// 设置筛选过滤条件，例如选择图片类型
PhotoSelectOptions.MIMEType = photoAccessHelper.PhotoViewMIMETypes.IMAGE_TYPE;
// 设置用户可以选择的图片数量
PhotoSelectOptions.maxSelectNumber = 1;

let photoPicker = new photoAccessHelper.PhotoViewPicker();



@Component
export default  struct QrCode {
  @Consume('pageInfos') pageInfos: NavPathStack;


  @State value: string = ''
  @State qrTxt: string = ''
  @State qrImg: string | null = null

  build() {
    NavDestination() {
      Column({space: 16}) {
        TextInput({placeholder: '请输入要生成的二维码内容', text: this.value})
          .onChange((value: string) => {
            this.value = value
          })

        Button('生成')
          .onClick(() => {
            if (this.value) {
              this.qrTxt = this.value
            }
          })
          .width('100%')

        if (this.qrTxt) {
          Column({space: 16}) {
            Row() {
              Button('背景色')
                .backgroundColor('#F1F3F5')
                .fontColor("#000")
              Blank()
              Button('前景色')
                .backgroundColor('#F1F3F5')
                .fontColor("#000")
            }
            .width('100%')

            Stack() {
              QRCode(this.qrTxt).width(220).height(220)

              if (this.qrImg) {
                Image(this.qrImg)
                  .width(40)
                  .height(40)
                  .borderRadius(20)
                  .onClick(() => {
                    // 选择图片
                    photoPicker.select(PhotoSelectOptions, (err: BusinessError, PhotoSelectResult: photoAccessHelper.PhotoSelectResult) => {
                      if (err) {
                        console.error("photoPicker.select error: " + JSON.stringify(err));
                        return;
                      }
                      // 用户选择确认后，会回调到这里，并返回用户选择的图片信息
                      console.info("photoPicker.select successfully: " + JSON.stringify(PhotoSelectResult), 'asfasfasfasfasdfasf------------');
                      this.qrImg = PhotoSelectResult.photoUris[0]
                      // 可以根据PhotoSelectResult中的信息进一步处理用户选择的图片
                    });
                  })
              } else {
                Button({ type: ButtonType.Circle }){
                  Text('+')
                    .fontColor('#000')
                    .fontWeight(600)
                    .fontSize(20)
                }
                .backgroundColor('#fff')
                .width(40)
                .height(40)
                .onClick(() => {
                  // 选择图片
                  photoPicker.select(PhotoSelectOptions, (err: BusinessError, PhotoSelectResult: photoAccessHelper.PhotoSelectResult) => {
                    if (err) {
                      console.error("photoPicker.select error: " + JSON.stringify(err));
                      return;
                    }
                    // 用户选择确认后，会回调到这里，并返回用户选择的图片信息
                    console.info("photoPicker.select successfully: " + JSON.stringify(PhotoSelectResult), 'asfasfasfasfasdfasf------------');
                    this.qrImg = PhotoSelectResult.photoUris[0]
                    // 可以根据PhotoSelectResult中的信息进一步处理用户选择的图片
                  });
                })
              }
            }

            Button('保存')
              .width('100%')
          }
          .width('100%')
        }

      }
      .width('100%')
      .height('100%')
      .padding(12)
    }.title("二维码生成器")
    .backgroundColor('#F1F3F5')
    .onBackPressed(() => {
      const popDestinationInfo = this.pageInfos.pop() // 弹出路由栈栈顶元素
      console.log('pop' + '返回值' + JSON.stringify(popDestinationInfo))
      return true
    })
  }
}
