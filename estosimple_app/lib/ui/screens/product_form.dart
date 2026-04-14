import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/product.dart';
import '../../providers/products_provider.dart';
import '../widgets/custom_text_field.dart';

class ProductForm extends StatefulWidget {
  final Product? product;

  const ProductForm({super.key, this.product});

  @override
  State<ProductForm> createState() => _ProductFormState();
}

class _ProductFormState extends State<ProductForm> {
  final _formKey = GlobalKey<FormState>();
  
  late final TextEditingController _nameController;
  late final TextEditingController _skuController;
  late final TextEditingController _descController;
  late final TextEditingController _priceController;

  bool get isEditing => widget.product != null;

  @override
  void initState() {
    super.initState();
    // Preenche os campos se estiver no modo de edição
    _nameController = TextEditingController(text: widget.product?.name ?? '');
    _skuController = TextEditingController(text: widget.product?.sku ?? '');
    _descController = TextEditingController(text: widget.product?.description ?? '');
    _priceController = TextEditingController(text: widget.product?.price.toString() ?? '');
  }

  @override
  void dispose() {
    _nameController.dispose();
    _skuController.dispose();
    _descController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  Future<void> _saveProduct() async {
    if (!_formKey.currentState!.validate()) return;

    final provider = context.read<ProductsProvider>();

    final productData = Product(
      id: isEditing ? widget.product!.id : 0, 
      name: _nameController.text,
      sku: _skuController.text,
      description: _descController.text,
      price: double.tryParse(_priceController.text) ?? 0.0,
    );

    if (isEditing) {
      await provider.updateProduct(productData);
    } else {
      await provider.addProduct(productData);
    }

    if (provider.error != null && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(provider.error!), backgroundColor: Colors.red));
    } else if (mounted) {
      Navigator.pop(context); // Volta para a tela anterior se der sucesso
    }
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = context.watch<ProductsProvider>().isLoading;

    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'Editar Produto' : 'Novo Produto'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            CustomTextField(
              label: 'Nome do Produto',
              controller: _nameController,
              validator: (val) => val!.isEmpty ? 'Campo obrigatório' : null,
            ),
            CustomTextField(
              label: 'SKU',
              controller: _skuController,
              validator: (val) => val!.isEmpty ? 'Campo obrigatório' : null,
            ),
            CustomTextField(
              label: 'Preço',
              controller: _priceController,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              validator: (val) {
                if (val!.isEmpty) return 'Campo obrigatório';
                if (double.tryParse(val) == null) return 'Digite um número válido';
                return null;
              },
            ),
            CustomTextField(
              label: 'Descrição',
              controller: _descController,
              maxLines: 3,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: isLoading ? null : _saveProduct,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: isLoading 
                  ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(strokeWidth: 2))
                  : Text(isEditing ? 'Atualizar' : 'Salvar'),
            ),
          ],
        ),
      ),
    );
  }
}