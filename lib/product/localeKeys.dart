enum LocaleKeys {

  splashScreen("developed by sfatihy"),

  // ONBOARDING
  onBoardingPage1("What \nis your \nusername/name ?"),
  onBoardingPage2("What is your \nmother \ntongue/language ?"),
  onBoardingPage3("What is your \nforeign language ?"),

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

  // ADD PAGE
  addPageTitle("Word Add"),
  wordAdd("Add"),
  randomWordAdd("Add random word"),
  sign("\u27AA")
  ;

  final value;
  const LocaleKeys(this.value);
}