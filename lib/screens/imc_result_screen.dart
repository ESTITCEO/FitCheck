import 'package:flutter/material.dart';
import 'package:imc_calculator/core/app_color.dart';
import 'package:imc_calculator/core/text_styles.dart';

class ImcResultScreen extends StatelessWidget {
  final double height;
  final int weight;
  const ImcResultScreen({
    super.key,
    required this.height,
    required this.weight,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: toolbarResult(),
      body: bodyResult(context),
    );
  }

  Padding bodyResult(BuildContext context) {
    double fixedHeight = height / 100;
    double ImcResult = weight / (fixedHeight * fixedHeight);

    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Tu Resultado',
            style: TextStyle(
              fontSize: 38,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 32, bottom: 32),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors.accent,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      getTitleByImc(ImcResult),
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w600,
                        color: getColorByImc(ImcResult),
                      ),
                    ),
                    Text(
                      ImcResult.toStringAsFixed(2),
                      style: TextStyle(
                        fontSize: 76,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      getDescriptionByImc(ImcResult),
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xFF000000),
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Image.asset(getImageByImc(ImcResult), height: 200),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 60,
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ButtonStyle(
                shape: WidgetStateProperty.all(
                  BeveledRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                backgroundColor: WidgetStatePropertyAll(AppColors.primary),
              ),
              child: Text('Finalizar', style: TextStyles.bodyText),
            ),
          ),
        ],
      ),
    );
  }

  AppBar toolbarResult() {
    return AppBar(
      backgroundColor: AppColors.primary,
      foregroundColor: Colors.white,
      title: Text('Resultado'),
    );
  }

  getColorByImc(double imcResult) {
    return switch (imcResult) {
      < 18.5 => const Color(0xFFB4A40F), // IMC BAJO PESO
      >= 18.5 && < 24.9 => Colors.green, // IMC NORMAL
      >= 25 && < 29.9 => Colors.orange, // IMC SOBREPESO
      _ => Colors.red, // IMC OBESIDAD
    };
  }

  String getTitleByImc(double imcResult) {
    return switch (imcResult) {
      < 18.5 => 'IMC BAJO PESO', // IMC BAJO PESO
      >= 18.5 && < 24.9 => 'IMC NORMAL', // IMC NORMAL
      >= 25 && < 29.9 => 'IMC SOBREPESO', // IMC SOBREPESO
      _ => 'IMC OBESO', // IMC OBESIDAD
    };
  }

  String getDescriptionByImc(double imcResult) {
    return switch (imcResult) {
      < 18.5 =>
        'Tienes un peso corporal inferior al normal. Puedes comer un poco más.', // IMC BAJO PESO
      >= 18.5 && < 24.9 =>
        'Tienes un peso corporal normal. ¡Buen trabajo!', // IMC NORMAL
      >= 25 && < 29.9 =>
        'Tienes un peso corporal superior al normal. Intenta hacer más ejercicio.', // IMC SOBREPESO
      _ =>
        'Tienes obesidad. Es importante que consultes a un médico para obtener asesoramiento sobre cómo perder peso de manera segura.', // IMC OBESIDAD
    };
  }

  String getImageByImc(double imcResult) {
    return switch (imcResult) {
      < 18.5 => 'assets/images/bajopeso.jpg', // IMC BAJO PESO
      >= 18.5 && < 24.9 => 'assets/images/tenor.gif', // IMC NORMAL
      >= 25 && < 29.9 => 'assets/images/sobrepeso.png', // IMC SOBREPESO
      _ => 'assets/images/obesidad.jpg', // IMC OBESIDAD
    };
  }
}
