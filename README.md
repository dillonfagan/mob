# Mob

Mob is a web-based mobbing app with some opinions about time management.

Mob was inspired by [Mobster](https://github.com/dillonkearns/mobster) and by pure coincidence, both creators are named Dillon.

## Time Management

The length of each mobber's turn depends on the number of people in the mob, shown below:

| Mobbers | Turn Length (minutes) |
| ------- | --------------------- |
| 1 | 15 |
| 2 - 3 | 8 |
| 4+ | 7 |

After about 45 minutes, the mob is always prompted to take a 10-minute break.

Though adding more than 4 mobbers is allowed by the app, it's recommended not to exceed 4 for optimal mob performance.

## Getting Started

**To start mobbing**, head over to the [live production version](https://dillonfagan.github.io/mob/).

### Contributing

To clone and run this code, you'll need to first install [Flutter](https://flutter.dev) and [Chrome](https://www.google.com/intl/en_in/chrome/).

```zsh
# Clone the repository
git clone https://github.com/dillonfagan/mob.git

# Go into the repository folder
cd mob

# Install app dependencies
flutter pub get

# Run the app in Chrome
flutter run -d chrome

# Build for release
flutter build web --release
```

This project was built using Flutter and its Material widget library.

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
