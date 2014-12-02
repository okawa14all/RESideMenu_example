class NotificationController < UIViewController

  def viewDidLoad
    super

    rmq.stylesheet = NotificationControllerStylesheet
    init_nav
    rmq(self.view).apply_style :root_view

  end

  def init_nav
    self.title = '通知'

    right_icon = FAKIonIcons.closeIconWithSize 20
    right_icon.addAttribute(NSForegroundColorAttributeName, value: rmq.color.dark_gray)
    right_icon_image = right_icon.imageWithSize(CGSizeMake(20, 20))
    self.navigationItem.tap do |nav|
      nav.rightBarButtonItem = UIBarButtonItem.alloc.initWithImage(
        right_icon_image.imageWithRenderingMode(UIImageRenderingModeAlwaysOriginal),
        style: UIBarButtonItemStylePlain,
        target: self,
        action: :dismissView
      )
    end
  end

  def dismissView
    self.dismissViewControllerAnimated(true, completion:nil)
  end

end
