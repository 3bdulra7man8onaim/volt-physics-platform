#!/bin/bash

# منصة الفولت في الفيزياء - سكريبت النشر
# تطوير: Abdulrahman Ghonaim

set -e

echo "🚀 بدء نشر منصة الفولت في الفيزياء..."

# ألوان للإخراج
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# متغيرات
PROJECT_NAME="volt-physics-platform"
DOMAIN="volt-physics.com"
BACKUP_DIR="./backups/$(date +%Y%m%d_%H%M%S)"

# وظائف مساعدة
log_info() {
    echo -e "${BLUE}ℹ️  $1${NC}"
}

log_success() {
    echo -e "${GREEN}✅ $1${NC}"
}

log_warning() {
    echo -e "${YELLOW}⚠️  $1${NC}"
}

log_error() {
    echo -e "${RED}❌ $1${NC}"
}

# التحقق من المتطلبات
check_requirements() {
    log_info "التحقق من المتطلبات..."
    
    if ! command -v docker &> /dev/null; then
        log_error "Docker غير مثبت. يرجى تثبيت Docker أولاً."
        exit 1
    fi
    
    if ! command -v docker-compose &> /dev/null; then
        log_error "Docker Compose غير مثبت. يرجى تثبيت Docker Compose أولاً."
        exit 1
    fi
    
    if ! command -v node &> /dev/null; then
        log_error "Node.js غير مثبت. يرجى تثبيت Node.js أولاً."
        exit 1
    fi
    
    log_success "جميع المتطلبات متوفرة"
}

# إنشاء نسخة احتياطية
create_backup() {
    log_info "إنشاء نسخة احتياطية..."
    
    mkdir -p "$BACKUP_DIR"
    
    # نسخ احتياطية لقاعدة البيانات
    if docker ps | grep -q volt-physics-db; then
        docker exec volt-physics-db mysqldump -u volt_user -pvolt_secure_password volt_physics > "$BACKUP_DIR/database.sql"
        log_success "تم إنشاء نسخة احتياطية لقاعدة البيانات"
    fi
    
    # نسخ احتياطية للملفات المرفوعة
    if [ -d "./uploads" ]; then
        cp -r ./uploads "$BACKUP_DIR/"
        log_success "تم إنشاء نسخة احتياطية للملفات المرفوعة"
    fi
    
    log_success "تم إنشاء النسخة الاحتياطية في: $BACKUP_DIR"
}

# بناء التطبيق
build_application() {
    log_info "بناء التطبيق..."
    
    # تثبيت التبعيات
    npm ci
    
    # بناء التطبيق للإنتاج
    npm run build
    
    log_success "تم بناء التطبيق بنجاح"
}

# بناء صور Docker
build_docker_images() {
    log_info "بناء صور Docker..."
    
    docker-compose build --no-cache
    
    log_success "تم بناء صور Docker بنجاح"
}

# نشر التطبيق
deploy_application() {
    log_info "نشر التطبيق..."
    
    # إيقاف الحاويات القديمة
    docker-compose down
    
    # تشغيل الحاويات الجديدة
    docker-compose up -d
    
    # انتظار تشغيل الخدمات
    log_info "انتظار تشغيل الخدمات..."
    sleep 30
    
    # التحقق من حالة الخدمات
    if docker-compose ps | grep -q "Up"; then
        log_success "تم نشر التطبيق بنجاح"
    else
        log_error "فشل في نشر التطبيق"
        exit 1
    fi
}

# فحص صحة التطبيق
health_check() {
    log_info "فحص صحة التطبيق..."
    
    # فحص الخادم الرئيسي
    if curl -f http://localhost/health > /dev/null 2>&1; then
        log_success "الخادم الرئيسي يعمل بشكل صحيح"
    else
        log_error "الخادم الرئيسي لا يستجيب"
        return 1
    fi
    
    # فحص API
    if curl -f http://localhost:5000/api/health > /dev/null 2>&1; then
        log_success "API يعمل بشكل صحيح"
    else
        log_error "API لا يستجيب"
        return 1
    fi
    
    # فحص قاعدة البيانات
    if docker exec volt-physics-db mysqladmin ping -h localhost -u volt_user -pvolt_secure_password > /dev/null 2>&1; then
        log_success "قاعدة البيانات تعمل بشكل صحيح"
    else
        log_error "قاعدة البيانات لا تستجيب"
        return 1
    fi
    
    log_success "جميع الخدمات تعمل بشكل صحيح"
}

# تنظيف الملفات القديمة
cleanup() {
    log_info "تنظيف الملفات القديمة..."
    
    # حذف الصور القديمة
    docker image prune -f
    
    # حذف الحاويات المتوقفة
    docker container prune -f
    
    # حذف الشبكات غير المستخدمة
    docker network prune -f
    
    log_success "تم تنظيف الملفات القديمة"
}

# إعداد SSL (اختياري)
setup_ssl() {
    if [ "$1" = "--ssl" ]; then
        log_info "إعداد شهادات SSL..."
        
        # إنشاء مجلد SSL
        mkdir -p ./nginx/ssl
        
        # يمكن إضافة كود لإنشاء شهادات Let's Encrypt هنا
        log_warning "يرجى إضافة شهادات SSL يدوياً في مجلد ./nginx/ssl/"
    fi
}

# الوظيفة الرئيسية
main() {
    echo "🎯 منصة الفولت في الفيزياء - مستر السيد محمد"
    echo "👨‍💻 تطوير: Abdulrahman Ghonaim"
    echo "🌐 الموقع: $DOMAIN"
    echo ""
    
    # التحقق من المعاملات
    case "$1" in
        "dev")
            log_info "نشر بيئة التطوير..."
            check_requirements
            build_application
            docker-compose -f docker-compose.dev.yml up -d
            ;;
        "prod")
            log_info "نشر بيئة الإنتاج..."
            check_requirements
            create_backup
            build_application
            build_docker_images
            deploy_application
            health_check
            cleanup
            setup_ssl "$2"
            ;;
        "backup")
            create_backup
            ;;
        "health")
            health_check
            ;;
        "cleanup")
            cleanup
            ;;
        *)
            echo "الاستخدام: $0 {dev|prod|backup|health|cleanup} [--ssl]"
            echo ""
            echo "الأوامر:"
            echo "  dev     - نشر بيئة التطوير"
            echo "  prod    - نشر بيئة الإنتاج"
            echo "  backup  - إنشاء نسخة احتياطية"
            echo "  health  - فحص صحة التطبيق"
            echo "  cleanup - تنظيف الملفات القديمة"
            echo ""
            echo "الخيارات:"
            echo "  --ssl   - إعداد شهادات SSL (مع prod فقط)"
            exit 1
            ;;
    esac
    
    log_success "تم الانتهاء من العملية بنجاح! 🎉"
    echo ""
    echo "🌐 يمكنك الآن زيارة الموقع على: http://localhost"
    echo "📊 لوحة المراقبة: http://localhost:9090"
    echo "📧 للدعم الفني: abdulrahman.ghonaim@gmail.com"
}

# تشغيل الوظيفة الرئيسية
main "$@"