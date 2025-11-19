import 'package:flutter/material.dart';
import 'package:online_class/core/utils/colors.dart';
import 'package:online_class/core/utils/utils.dart';
import 'package:online_class/feature/auth/service/auth_method.dart';

class GoogleLoginScreen extends StatefulWidget {
  const GoogleLoginScreen({super.key});

  @override
  State<GoogleLoginScreen> createState() => _GoogleLoginScreenState();
}

class _GoogleLoginScreenState extends State<GoogleLoginScreen> {
  bool _isLoading = false;

  Future<void> _handleGoogleSignIn() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final userCredential = await GoogleSignInService.signInWithGoogle();
      if (!mounted) return;
      if (userCredential != null) {
        showAppSnackbar(
          context: context,
          type: SnackbarType.success,
          description: 'Signed in with Google',
        );
      }
    } catch (e) {
      if (!mounted) return;

      showAppSnackbar(
        context: context,
        type: SnackbarType.error,
        description: 'Failed to sign in with Google: $e',
      );
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: bodyColor,
      body: SafeArea(
        child: Column(
          children: [
            // image covering about 60% of the screen height
            SizedBox(
              height: size.height * 0.6,
              width: double.infinity,
              child: Image.asset(
                'assets/images/login_image.png',
                fit: BoxFit.cover,
              ),
            ),
            const Spacer(),
            _isLoading
                ? const CircularProgressIndicator()
                : Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24.0,
                      vertical: 16,
                    ),
                    child: GestureDetector(
                      onTap: () => _handleGoogleSignIn(),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 16,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 6,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Google icon - replace with your asset if you have one
                            Icon(
                              Icons.g_mobiledata,
                              color: Colors.red,
                              size: 28,
                            ),
                            const SizedBox(width: 12),
                            const Text(
                              'Sign in with Google',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}