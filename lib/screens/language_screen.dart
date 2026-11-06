import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../l10n/app_localizations.dart';
import '../services/locale_controller.dart';
import '../theme/app_colors.dart';
import '../theme/theme_controller.dart';

class LanguageScreen extends StatefulWidget {
  const LanguageScreen({super.key});

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  final TextEditingController _search = TextEditingController();
  String _query = '';

  // 👈 Naya variable: User ne filhal kaunsi language select ki hai (bina save kiye)
  String? _tempSelectedCode;

  @override
  void dispose() {
    _search.dispose();
    super.dispose();
  }

  // English naam, apni zabaan ka naam ya code, kisi se bhi dhoondh sakte hain
  List<AppLanguage> get _filtered {
    final String q = _query.trim().toLowerCase();
    if (q.isEmpty) return LocaleController.languages;
    return LocaleController.languages
        .where(
          (l) =>
              l.name.toLowerCase().contains(q) ||
              l.nativeName.toLowerCase().contains(q) ||
              l.code == q,
        )
        .toList();
  }

  // 👈 Jab upar wale Tick button par press ho to ye function chalega
  Future<void> _saveSelected() async {
    // Agar user ne kuch select kiya hai to usko save karo
    if (_tempSelectedCode != null) {
      await LocaleController.instance.setLanguage(_tempSelectedCode!);
    }
    if (!mounted) return;
    Navigator.pop(context); // Screen wapas band karo
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: Listenable.merge([
        ThemeController.instance,
        LocaleController.instance,
      ]),
      builder: (context, _) {
        final AppColors c = AppColors.current;
        final AppLocalizations t = AppLocalizations.of(context)!;

        // Asal saved language
        final String currentSaved = LocaleController.instance.code ??
            Localizations.localeOf(context).languageCode;
            
        // Jo abhi user ne select ki hai, agar kuch select nahi kiya to saved wali dikhao
        final String currentlySelected = _tempSelectedCode ?? currentSaved;
        
        final List<AppLanguage> items = _filtered;

        return Scaffold(
          backgroundColor: c.background,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            scrolledUnderElevation: 0,
            systemOverlayStyle:
                c.isDark ? SystemUiOverlayStyle.light : SystemUiOverlayStyle.dark,
            leading: IconButton(
              icon: Icon(LucideIcons.arrowLeft, color: c.title),
              onPressed: () => Navigator.maybePop(context),
            ),
            title: Text(
              t.language,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w700,
                color: c.title,
              ),
            ),
            // 👈 Yahan AppBar ke right side mein Tick button add kiya hai
            actions: [
              IconButton(
                onPressed: _saveSelected, // Tick dabane par language save hogi
                icon: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: c.accent, // Green background
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.check,
                    size: 18,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(width: 8), // Thoda margin right side se
            ],
          ),
          body: Column(
            children: [
              // ---------- Search bar ----------
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 14),
                child: Container(
                  decoration: BoxDecoration(
                    color: c.card,
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(color: c.border),
                  ),
                  child: TextField(
                    controller: _search,
                    onChanged: (value) => setState(() => _query = value),
                    style: TextStyle(color: c.title, fontSize: 16),
                    decoration: InputDecoration(
                      hintText: t.searchLanguage,
                      hintStyle: TextStyle(color: c.grey(500), fontSize: 16),
                      prefixIcon: Icon(
                        LucideIcons.search,
                        color: c.grey(500),
                        size: 22,
                      ),
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(vertical: 18),
                    ),
                  ),
                ),
              ),

              // ---------- Har zabaan ka alag card ----------
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    final AppLanguage l = items[index];
                    final bool isSelected = l.code == currentlySelected;
                    return _languageCard(c, l, isSelected);
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _languageCard(AppColors c, AppLanguage l, bool selected) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Material(
        color: selected ? c.highlight : c.card,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
          side: BorderSide(
            color: selected ? c.accent : Colors.transparent,
            width: 1.5,
          ),
        ),
        child: InkWell(
          customBorder: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          // 👈 Card par tap karne se sirf select hoga (screen close nahi hogi)
          onTap: () {
            setState(() {
              _tempSelectedCode = l.code;
            });
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
            child: Row(
              children: [
                Text(l.flag, style: const TextStyle(fontSize: 26)),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    l.name,
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: selected ? FontWeight.w700 : FontWeight.w600,
                      color: selected ? c.accent : c.title,
                    ),
                  ),
                ),
                // 👈 Card ke andar wala purana check icon waisa hi rahega
                if (selected)
                  Icon(Icons.check_circle, size: 26, color: c.accent),
              ],
            ),
          ),
        ),
      ),
    );
  }
}