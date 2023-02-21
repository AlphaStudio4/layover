part of 'onboarding_bloc.dart';

abstract class OnboardingEvent extends Equatable {
  const OnboardingEvent();

  @override
  List<Object?> get props => [];
}

class StartOnboarding extends OnboardingEvent {
  final User user;

  const StartOnboarding({
    this.user = const User(
        id: '',
        name: '',
        status: 'Out of Boundary',
        location: 'You Are Out of Boundary',
        age: 0,
        gender: '',
        imageUrls: [],
        interest: [],
        bio: '',
        likes: 0,
        jobTitle: ''),
  });

  @override
  List<Object?> get props => [];
}

class UpdateUser extends OnboardingEvent {
  final User user;

  const UpdateUser({required this.user});

  @override
  List<Object?> get props => [user];
}

class UpdateUserImages extends OnboardingEvent {
  final User? user;
  final XFile image;

  const UpdateUserImages({required this.image, this.user});

  @override
  List<Object?> get props => [user, image];
}
