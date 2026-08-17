import 'package:assignment_tracker/app/app_theme.dart';
import 'package:assignment_tracker/custom/custom_text.dart';
import 'package:assignment_tracker/provider/auth_provider.dart';
import 'package:assignment_tracker/provider/profile_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      if (mounted) {
        context.read<ProfileProvider>().fetchProfile();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final profile = context.watch<ProfileProvider>();

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: profile.isLoading
              ? const Center(child: CircularProgressIndicator())
              : profile.user == null
              ? _ProfileError(message: profile.errorMessage)
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CustomText(
                      text: 'Profile',
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                    ),
                    const SizedBox(height: 28),
                    Center(
                      child: _ProfileAvatar(imageUrl: profile.user!.profileImg),
                    ),
                    const SizedBox(height: 14),
                    Center(
                      child: CustomText(
                        text: profile.user!.fullName,
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Center(
                      child: CustomText(
                        text: profile.user!.email,
                        fontSize: 14,
                        color: AppColors.tertiary,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Center(
                      child: OutlinedButton.icon(
                        onPressed: null,
                        icon: Icon(Icons.photo_camera_outlined),
                        label: Text('Change photo'),
                      ),
                    ),
                    const SizedBox(height: 32),
                    const CustomText(
                      text: 'Account details',
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                    const SizedBox(height: 14),
                    _DetailTile(
                      icon: Icons.person_outline,
                      label: 'Full name',
                      value: profile.user!.fullName,
                    ),
                    const SizedBox(height: 12),
                    _DetailTile(
                      icon: Icons.email_outlined,
                      label: 'Email address',
                      value: profile.user!.email,
                    ),
                    const Spacer(),
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton.icon(
                        onPressed: () async {
                          context.read<ProfileProvider>().clearProfile();
                          await context.read<AuthProvider>().logout();
                        },
                        icon: const Icon(Icons.logout),
                        label: const Text('Logout'),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: AppColors.primary,
                          side: const BorderSide(
                            color: AppColors.primary,
                            width: 1.25,
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                        ),
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}

class _ProfileAvatar extends StatelessWidget {
  const _ProfileAvatar({this.imageUrl});

  final String? imageUrl;

  bool get _hasUsableImage {
    final uri = Uri.tryParse(imageUrl?.trim() ?? '');
    return uri != null && (uri.scheme == 'http' || uri.scheme == 'https');
  }

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 54,
      backgroundColor: AppColors.secondary,
      child: ClipOval(
        child: SizedBox(
          width: 108,
          height: 108,
          child: _hasUsableImage
              ? Image.network(
                  imageUrl!.trim(),
                  fit: BoxFit.cover,
                  errorBuilder: (_, _, _) => const _AvatarPlaceholder(),
                )
              : const _AvatarPlaceholder(),
        ),
      ),
    );
  }
}

class _AvatarPlaceholder extends StatelessWidget {
  const _AvatarPlaceholder();

  @override
  Widget build(BuildContext context) {
    return const ColoredBox(
      color: AppColors.secondary,
      child: Center(
        child: Icon(Icons.person_outline, size: 52, color: AppColors.primary),
      ),
    );
  }
}

class _DetailTile extends StatelessWidget {
  const _DetailTile({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.secondary,
        border: Border.all(color: AppColors.border, width: 1.25),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          Icon(icon, color: AppColors.primary),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: label,
                  fontSize: 13,
                  color: AppColors.tertiary,
                ),
                const SizedBox(height: 3),
                CustomText(
                  text: value,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ProfileError extends StatelessWidget {
  const _ProfileError({this.message});

  final String? message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.person_outline, size: 52, color: AppColors.tertiary),
          const SizedBox(height: 12),
          const CustomText(
            text: 'Unable to load profile',
            fontSize: 17,
            fontWeight: FontWeight.w600,
          ),
          if (message != null) ...[
            const SizedBox(height: 6),
            CustomText(text: message!, fontSize: 13, color: AppColors.tertiary),
          ],
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () => context.read<ProfileProvider>().fetchProfile(),
            child: const Text('Try again'),
          ),
        ],
      ),
    );
  }
}
