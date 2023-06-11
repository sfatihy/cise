enum LocaleKeys {

  splashScreen("developed by sfatihy"),

  // ONBOARDING
  onBoardingPage1("What \nis your \nusername/name ?"),
  onBoardingPage2("What is your \nmother \ntongue/language ?"),
  onBoardingPage3("What is your \nforeign language ?"),

  onBoardingPage([
    "You can create words list.",
    "You can add words.",
    "You can create tags.",
    "You can edit tag.",
    "You can sort list.",
    "You can see your profile."
  ]),

  onBoardingMotherLanguage("Mother Language"),
  onBoardingForeignLanguage("Foreign Language"),

  onBoardingSkipButton("Skip"),
  onBoardingNextButton("Next"),
  onBoardingDoneButton("Done"),
  onBoardingCreateUserButton("Create User"),

  // DRAWER
  gameSpace("Game Space"),
  collections("Collections"),
  books("Books"),
  weeklyReport("Weekly Report"),
  randomWords("Random Words"),
  settings("Settings"),
  info("Info"),
  privacyPolicy("Privacy Policy"),

  // NAVIGATION
  card("Cards"),
  person("User"),

  // SNACKBAR
  notAvailable("Not available."),

  // BUTTON
  deleteButton("Delete"),
  editButton("Edit"),
  memorizedButton("Memorized"),
  notMemorizedButton("Not Memorized"),
  saveButton("Save"),

  // PROFILE PAGE
  profilePage(["You have learned today.", "You have learned words.", "You will learn.", "Total words."]),

  // SETTINGS PAGE
  personalInformation("Personal Information"),
  application("Application"),
  username("username"),
  native("native  "),
  learning("learning"),
  dark("Dark"),
  light("Light"),

  // ALERT
  alertDelete("Delete"),

  // ADD PAGE
  addPageTitle("Word Add"),
  wordAdd("Add"),
  randomWordAdd("Add random word"),
  sign("\u27AA"),
  updateTag("Change Tag"),
  deleteTag("Delete Tag!"),
  permissionDeleteTagContent("Are you sure you want to delete this tag: ")
  ;

  final value;
  const LocaleKeys(this.value);
}