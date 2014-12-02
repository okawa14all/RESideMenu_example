class AppDelegate
  attr_reader :window, :rooms

  def application(application, didFinishLaunchingWithOptions:launchOptions)
    @window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)

    @rooms = [
      { id: 1, name: 'ルーム1', members: ['Aさん', 'Bさん', 'Cさん'] },
      { id: 2, name: 'ルーム2', members: ['Aさん', 'Dさん', 'Eさん'] },
      { id: 3, name: 'ルーム3', members: ['Aさん', 'Fさん', 'Gさん'] },
    ]

    timeline_controller = TimelineController.new
    timeline_controller.current_room = @rooms.first
    navigation_controller = UINavigationController.alloc.initWithRootViewController(timeline_controller)

    left_menu_controller = LeftMenuController.new

    right_menu_controller = RightMenuController.new
    right_menu_controller.members = @rooms.first[:members]

    side_menu_controller = RESideMenu.alloc.initWithContentViewController(
      navigation_controller,
      leftMenuViewController: left_menu_controller,
      rightMenuViewController: right_menu_controller).tap do |smc|
        smc.backgroundImage = UIImage.imageNamed 'menu_bg'
        smc.menuPreferredStatusBarStyle = 1 # UIStatusBarStyleLightContent
        smc.panGestureEnabled = false
        smc.delegate = timeline_controller
        smc.contentViewScaleValue = 0.8
        smc.contentViewInPortraitOffsetCenterX = 80.0
        smc.contentViewShadowColor = UIColor.blackColor
        smc.contentViewShadowOffset = CGSizeMake(0, 0)
        smc.contentViewShadowOpacity = 0.6
        smc.contentViewShadowRadius = 12
        smc.contentViewShadowEnabled = true
    end

    @window.rootViewController = side_menu_controller

    @window.makeKeyAndVisible
    true
  end

end
